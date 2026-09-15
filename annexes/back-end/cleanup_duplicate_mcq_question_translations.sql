-- Translation-table equivalent of cleanup_duplicate_mcq_questions.sql.
--
-- That script blanks component_mcq.question when it duplicates the sibling
-- "text" component's content, fixing the duplicate-question bug for the base
-- (English) locale. Per-locale overrides live separately in
-- content_translation (table_name='component_mcq', field_name='question'),
-- written by annexes/automation_server/src/database/translation_importer.py.
-- upsert_translation() never clears a row for an empty/blank value (so a
-- blank Excel cell doesn't wipe a real translation), so stale duplicate
-- question translations imported before the excel_loader.py fix survive
-- even a fresh re-import. This deletes those stale content_translation rows,
-- comparing each MCQ's translated question against the translated content of
-- its card's sibling text component for that same locale.
-- See cleanup_duplicate_mcq_question_translations.py for the Python
-- equivalent (dry-run preview, --owner-type/--owner-id/--locale filters).

-- 1) Preview affected rows first.
SELECT
    ct_mcq.id       AS translation_id,
    c.id            AS card_id,
    c.owner_type,
    c.owner_id,
    c.card_order_index,
    mcq.id          AS mcq_id,
    ct_mcq.locale,
    LEFT(ct_mcq.value, 80) AS question_preview
FROM content_translation ct_mcq
JOIN component_mcq mcq ON mcq.id = ct_mcq.row_id
JOIN card_contains cc_mcq ON cc_mcq.component_type = 'mcq' AND cc_mcq.component_id = mcq.id
JOIN card c ON c.id = cc_mcq.card_id
JOIN card_contains cc_text ON cc_text.card_id = c.id AND cc_text.component_type = 'text'
JOIN component_text ct ON ct.id = cc_text.component_id
WHERE ct_mcq.table_name = 'component_mcq'
  AND ct_mcq.field_name = 'question'
  AND TRIM(ct_mcq.value) <> ''
  AND TRIM(ct_mcq.value) = TRIM(COALESCE(
        (SELECT value FROM content_translation ct_text
         WHERE ct_text.table_name = 'component_text'
           AND ct_text.field_name = 'content'
           AND ct_text.row_id = ct.id
           AND ct_text.locale = ct_mcq.locale),
        ct.content
      ));

-- 2) Apply: delete the duplicated per-locale question translations so the
--    frontend falls back to the base component_mcq.question (already
--    blanked by cleanup_duplicate_mcq_questions.sql) instead of repeating
--    the translated text.
--    (Wrapped in a derived table because MySQL forbids deleting from a table
--    while selecting from it directly in the same statement - error 1093.)
DELETE FROM content_translation
WHERE id IN (
    SELECT translation_id FROM (
        SELECT ct_mcq.id AS translation_id
        FROM content_translation ct_mcq
        JOIN component_mcq mcq ON mcq.id = ct_mcq.row_id
        JOIN card_contains cc_mcq ON cc_mcq.component_type = 'mcq' AND cc_mcq.component_id = mcq.id
        JOIN card c ON c.id = cc_mcq.card_id
        JOIN card_contains cc_text ON cc_text.card_id = c.id AND cc_text.component_type = 'text'
        JOIN component_text ct ON ct.id = cc_text.component_id
        WHERE ct_mcq.table_name = 'component_mcq'
          AND ct_mcq.field_name = 'question'
          AND TRIM(ct_mcq.value) <> ''
          AND TRIM(ct_mcq.value) = TRIM(COALESCE(
                (SELECT value FROM content_translation ct_text
                 WHERE ct_text.table_name = 'component_text'
                   AND ct_text.field_name = 'content'
                   AND ct_text.row_id = ct.id
                   AND ct_text.locale = ct_mcq.locale),
                ct.content
              ))
    ) AS dup
);
