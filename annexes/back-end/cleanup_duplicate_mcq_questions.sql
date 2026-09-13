-- Fix simulator/module cards where the MCQ component's question duplicates
-- the sibling "text" component on the same card (situation text rendered
-- twice: once as the text paragraph, once as the MCQ's question label).
-- See annexes/back-end/cleanup_duplicate_mcq_questions.py for the Python
-- equivalent and background.

-- 1) Preview affected rows first.
SELECT
    c.id                AS card_id,
    c.owner_type,
    c.owner_id,
    c.card_order_index,
    mcq.id              AS mcq_id,
    LEFT(mcq.question, 80) AS question_preview
FROM component_mcq mcq
JOIN card_contains cc_mcq ON cc_mcq.component_type = 'mcq' AND cc_mcq.component_id = mcq.id
JOIN card c ON c.id = cc_mcq.card_id
JOIN card_contains cc_text ON cc_text.card_id = c.id AND cc_text.component_type = 'text'
JOIN component_text ct ON ct.id = cc_text.component_id
WHERE TRIM(mcq.question) <> ''
  AND TRIM(mcq.question) = TRIM(ct.content);

-- 2) Apply: blank out the duplicated question so the frontend falls back to
--    its default "select an option" label instead of repeating the text.
--    (Wrapped in a derived table because MySQL forbids updating a table
--    while selecting from it directly in the same statement - error 1093.)
UPDATE component_mcq
SET question = ''
WHERE id IN (
    SELECT mcq_id FROM (
        SELECT mcq.id AS mcq_id
        FROM component_mcq mcq
        JOIN card_contains cc_mcq ON cc_mcq.component_type = 'mcq' AND cc_mcq.component_id = mcq.id
        JOIN card c ON c.id = cc_mcq.card_id
        JOIN card_contains cc_text ON cc_text.card_id = c.id AND cc_text.component_type = 'text'
        JOIN component_text ct ON ct.id = cc_text.component_id
        WHERE TRIM(mcq.question) <> ''
          AND TRIM(mcq.question) = TRIM(ct.content)
    ) AS dup
);
