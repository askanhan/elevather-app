-- ============================================================
-- Missing translations report, per language.
--
-- Lists every module/simulator/card/component field that has real
-- (non-empty) English content but no matching row in content_translation
-- for the given locale - i.e. exactly what still needs translating,
-- with its table, row id, a human-readable location, and the English
-- text to translate.
--
-- Usage:
--   CALL sp_missing_translations('pl');   -- full detail, one language
--   CALL sp_missing_translations('nl');
--   CALL sp_missing_translations('cs');
--   CALL sp_missing_translations('el');
--   CALL sp_missing_translations_summary();  -- just the counts, all 4 languages
--
-- (Re-run this file any time to update the procedures after content changes.)
-- ============================================================

DELIMITER $$

DROP PROCEDURE IF EXISTS sp_refresh_missing_translations$$

-- Internal: (re)fills tmp_missing_translations for one locale. Both
-- sp_missing_translations() and sp_missing_translations_summary() call this
-- so the "what counts as missing" logic lives in exactly one place.
CREATE PROCEDURE sp_refresh_missing_translations(IN p_locale VARCHAR(10))
BEGIN
    DROP TEMPORARY TABLE IF EXISTS tmp_missing_translations;
    CREATE TEMPORARY TABLE tmp_missing_translations (
        table_name VARCHAR(50),
        row_id INT,
        field_name VARCHAR(50),
        location TEXT,
        english_value TEXT
    );

    INSERT INTO tmp_missing_translations (table_name, row_id, field_name, location, english_value)

        -- module -----------------------------------------------------
        SELECT 'module' AS table_name, m.id AS row_id, 'title' AS field_name,
               CONCAT("Module '", m.title, "' (day ", m.day_number, ')') AS location,
               m.title AS english_value
        FROM module m
        WHERE m.title IS NOT NULL AND m.title <> ''
          AND NOT EXISTS (SELECT 1 FROM content_translation ct
                           WHERE ct.table_name = 'module' AND ct.row_id = m.id
                             AND ct.field_name = 'title' AND ct.locale = p_locale)

        UNION ALL
        SELECT 'module', m.id, 'description',
               CONCAT("Module '", m.title, "' (day ", m.day_number, ')'),
               m.description
        FROM module m
        WHERE m.description IS NOT NULL AND m.description <> ''
          AND NOT EXISTS (SELECT 1 FROM content_translation ct
                           WHERE ct.table_name = 'module' AND ct.row_id = m.id
                             AND ct.field_name = 'description' AND ct.locale = p_locale)

        UNION ALL
        SELECT 'module', m.id, 'target_audience',
               CONCAT("Module '", m.title, "' (day ", m.day_number, ')'),
               m.target_audience
        FROM module m
        WHERE m.target_audience IS NOT NULL AND m.target_audience <> ''
          AND NOT EXISTS (SELECT 1 FROM content_translation ct
                           WHERE ct.table_name = 'module' AND ct.row_id = m.id
                             AND ct.field_name = 'target_audience' AND ct.locale = p_locale)

        -- simulator ----------------------------------------------------
        UNION ALL
        SELECT 'simulator', s.id, 'title',
               CONCAT("Simulator '", s.title, "'"),
               s.title
        FROM simulator s
        WHERE s.title IS NOT NULL AND s.title <> ''
          AND NOT EXISTS (SELECT 1 FROM content_translation ct
                           WHERE ct.table_name = 'simulator' AND ct.row_id = s.id
                             AND ct.field_name = 'title' AND ct.locale = p_locale)

        UNION ALL
        SELECT 'simulator', s.id, 'description',
               CONCAT("Simulator '", s.title, "'"),
               s.description
        FROM simulator s
        WHERE s.description IS NOT NULL AND s.description <> ''
          AND NOT EXISTS (SELECT 1 FROM content_translation ct
                           WHERE ct.table_name = 'simulator' AND ct.row_id = s.id
                             AND ct.field_name = 'description' AND ct.locale = p_locale)

        -- card (title / subtitle / end_text / why_this_question) -------
        UNION ALL
        SELECT 'card', c.id, 'title',
               CASE WHEN c.owner_type = 'module'
                    THEN CONCAT("Module '", m.title, "' (day ", m.day_number, '), card ', c.card_order_index)
                    ELSE CONCAT("Simulator '", s.title, "', card ", c.card_order_index) END,
               c.title
        FROM card c
        LEFT JOIN module m ON c.owner_type = 'module' AND m.id = c.owner_id
        LEFT JOIN simulator s ON c.owner_type = 'simulator' AND s.id = c.owner_id
        WHERE c.title IS NOT NULL AND c.title <> ''
          AND NOT EXISTS (SELECT 1 FROM content_translation ct
                           WHERE ct.table_name = 'card' AND ct.row_id = c.id
                             AND ct.field_name = 'title' AND ct.locale = p_locale)

        UNION ALL
        SELECT 'card', c.id, 'subtitle',
               CASE WHEN c.owner_type = 'module'
                    THEN CONCAT("Module '", m.title, "' (day ", m.day_number, '), card ', c.card_order_index)
                    ELSE CONCAT("Simulator '", s.title, "', card ", c.card_order_index) END,
               c.subtitle
        FROM card c
        LEFT JOIN module m ON c.owner_type = 'module' AND m.id = c.owner_id
        LEFT JOIN simulator s ON c.owner_type = 'simulator' AND s.id = c.owner_id
        WHERE c.subtitle IS NOT NULL AND c.subtitle <> ''
          AND NOT EXISTS (SELECT 1 FROM content_translation ct
                           WHERE ct.table_name = 'card' AND ct.row_id = c.id
                             AND ct.field_name = 'subtitle' AND ct.locale = p_locale)

        UNION ALL
        SELECT 'card', c.id, 'end_text',
               CASE WHEN c.owner_type = 'module'
                    THEN CONCAT("Module '", m.title, "' (day ", m.day_number, '), card ', c.card_order_index)
                    ELSE CONCAT("Simulator '", s.title, "', card ", c.card_order_index) END,
               c.end_text
        FROM card c
        LEFT JOIN module m ON c.owner_type = 'module' AND m.id = c.owner_id
        LEFT JOIN simulator s ON c.owner_type = 'simulator' AND s.id = c.owner_id
        WHERE c.end_text IS NOT NULL AND c.end_text <> ''
          AND NOT EXISTS (SELECT 1 FROM content_translation ct
                           WHERE ct.table_name = 'card' AND ct.row_id = c.id
                             AND ct.field_name = 'end_text' AND ct.locale = p_locale)

        UNION ALL
        SELECT 'card', c.id, 'why_this_question',
               CASE WHEN c.owner_type = 'module'
                    THEN CONCAT("Module '", m.title, "' (day ", m.day_number, '), card ', c.card_order_index)
                    ELSE CONCAT("Simulator '", s.title, "', card ", c.card_order_index) END,
               c.why_this_question
        FROM card c
        LEFT JOIN module m ON c.owner_type = 'module' AND m.id = c.owner_id
        LEFT JOIN simulator s ON c.owner_type = 'simulator' AND s.id = c.owner_id
        WHERE c.why_this_question IS NOT NULL AND c.why_this_question <> ''
          AND NOT EXISTS (SELECT 1 FROM content_translation ct
                           WHERE ct.table_name = 'card' AND ct.row_id = c.id
                             AND ct.field_name = 'why_this_question' AND ct.locale = p_locale)

        -- component_title.content ---------------------------------------
        UNION ALL
        SELECT 'component_title', comp.id, 'content',
               CASE WHEN c.owner_type = 'module'
                    THEN CONCAT("Module '", m.title, "' (day ", m.day_number, '), card ', c.card_order_index)
                    ELSE CONCAT("Simulator '", s.title, "', card ", c.card_order_index) END,
               comp.content
        FROM component_title comp
        JOIN card_contains cc ON cc.component_id = comp.id AND cc.component_type = 'title'
        JOIN card c ON c.id = cc.card_id
        LEFT JOIN module m ON c.owner_type = 'module' AND m.id = c.owner_id
        LEFT JOIN simulator s ON c.owner_type = 'simulator' AND s.id = c.owner_id
        WHERE comp.content IS NOT NULL AND comp.content <> ''
          AND NOT EXISTS (SELECT 1 FROM content_translation ct
                           WHERE ct.table_name = 'component_title' AND ct.row_id = comp.id
                             AND ct.field_name = 'content' AND ct.locale = p_locale)

        -- component_subtitle.content --------------------------------------
        UNION ALL
        SELECT 'component_subtitle', comp.id, 'content',
               CASE WHEN c.owner_type = 'module'
                    THEN CONCAT("Module '", m.title, "' (day ", m.day_number, '), card ', c.card_order_index)
                    ELSE CONCAT("Simulator '", s.title, "', card ", c.card_order_index) END,
               comp.content
        FROM component_subtitle comp
        JOIN card_contains cc ON cc.component_id = comp.id AND cc.component_type = 'subtitle'
        JOIN card c ON c.id = cc.card_id
        LEFT JOIN module m ON c.owner_type = 'module' AND m.id = c.owner_id
        LEFT JOIN simulator s ON c.owner_type = 'simulator' AND s.id = c.owner_id
        WHERE comp.content IS NOT NULL AND comp.content <> ''
          AND NOT EXISTS (SELECT 1 FROM content_translation ct
                           WHERE ct.table_name = 'component_subtitle' AND ct.row_id = comp.id
                             AND ct.field_name = 'content' AND ct.locale = p_locale)

        -- component_text.content --------------------------------------
        UNION ALL
        SELECT 'component_text', comp.id, 'content',
               CASE WHEN c.owner_type = 'module'
                    THEN CONCAT("Module '", m.title, "' (day ", m.day_number, '), card ', c.card_order_index)
                    ELSE CONCAT("Simulator '", s.title, "', card ", c.card_order_index) END,
               comp.content
        FROM component_text comp
        JOIN card_contains cc ON cc.component_id = comp.id AND cc.component_type = 'text'
        JOIN card c ON c.id = cc.card_id
        LEFT JOIN module m ON c.owner_type = 'module' AND m.id = c.owner_id
        LEFT JOIN simulator s ON c.owner_type = 'simulator' AND s.id = c.owner_id
        WHERE comp.content IS NOT NULL AND comp.content <> ''
          AND NOT EXISTS (SELECT 1 FROM content_translation ct
                           WHERE ct.table_name = 'component_text' AND ct.row_id = comp.id
                             AND ct.field_name = 'content' AND ct.locale = p_locale)

        -- component_quote.content (author is not translated) -----------
        UNION ALL
        SELECT 'component_quote', comp.id, 'content',
               CASE WHEN c.owner_type = 'module'
                    THEN CONCAT("Module '", m.title, "' (day ", m.day_number, '), card ', c.card_order_index)
                    ELSE CONCAT("Simulator '", s.title, "', card ", c.card_order_index) END,
               comp.content
        FROM component_quote comp
        JOIN card_contains cc ON cc.component_id = comp.id AND cc.component_type = 'quote'
        JOIN card c ON c.id = cc.card_id
        LEFT JOIN module m ON c.owner_type = 'module' AND m.id = c.owner_id
        LEFT JOIN simulator s ON c.owner_type = 'simulator' AND s.id = c.owner_id
        WHERE comp.content IS NOT NULL AND comp.content <> ''
          AND NOT EXISTS (SELECT 1 FROM content_translation ct
                           WHERE ct.table_name = 'component_quote' AND ct.row_id = comp.id
                             AND ct.field_name = 'content' AND ct.locale = p_locale)

        -- component_image (alt / description - not the image_url) -----
        UNION ALL
        SELECT 'component_image', comp.id, 'image_alt',
               CASE WHEN c.owner_type = 'module'
                    THEN CONCAT("Module '", m.title, "' (day ", m.day_number, '), card ', c.card_order_index)
                    ELSE CONCAT("Simulator '", s.title, "', card ", c.card_order_index) END,
               comp.image_alt
        FROM component_image comp
        JOIN card_contains cc ON cc.component_id = comp.id AND cc.component_type = 'image'
        JOIN card c ON c.id = cc.card_id
        LEFT JOIN module m ON c.owner_type = 'module' AND m.id = c.owner_id
        LEFT JOIN simulator s ON c.owner_type = 'simulator' AND s.id = c.owner_id
        WHERE comp.image_alt IS NOT NULL AND comp.image_alt <> ''
          AND NOT EXISTS (SELECT 1 FROM content_translation ct
                           WHERE ct.table_name = 'component_image' AND ct.row_id = comp.id
                             AND ct.field_name = 'image_alt' AND ct.locale = p_locale)

        UNION ALL
        SELECT 'component_image', comp.id, 'image_description',
               CASE WHEN c.owner_type = 'module'
                    THEN CONCAT("Module '", m.title, "' (day ", m.day_number, '), card ', c.card_order_index)
                    ELSE CONCAT("Simulator '", s.title, "', card ", c.card_order_index) END,
               comp.image_description
        FROM component_image comp
        JOIN card_contains cc ON cc.component_id = comp.id AND cc.component_type = 'image'
        JOIN card c ON c.id = cc.card_id
        LEFT JOIN module m ON c.owner_type = 'module' AND m.id = c.owner_id
        LEFT JOIN simulator s ON c.owner_type = 'simulator' AND s.id = c.owner_id
        WHERE comp.image_description IS NOT NULL AND comp.image_description <> ''
          AND NOT EXISTS (SELECT 1 FROM content_translation ct
                           WHERE ct.table_name = 'component_image' AND ct.row_id = comp.id
                             AND ct.field_name = 'image_description' AND ct.locale = p_locale)

        -- component_video (alt / description - not the video_url) -----
        UNION ALL
        SELECT 'component_video', comp.id, 'video_alt',
               CASE WHEN c.owner_type = 'module'
                    THEN CONCAT("Module '", m.title, "' (day ", m.day_number, '), card ', c.card_order_index)
                    ELSE CONCAT("Simulator '", s.title, "', card ", c.card_order_index) END,
               comp.video_alt
        FROM component_video comp
        JOIN card_contains cc ON cc.component_id = comp.id AND cc.component_type = 'video'
        JOIN card c ON c.id = cc.card_id
        LEFT JOIN module m ON c.owner_type = 'module' AND m.id = c.owner_id
        LEFT JOIN simulator s ON c.owner_type = 'simulator' AND s.id = c.owner_id
        WHERE comp.video_alt IS NOT NULL AND comp.video_alt <> ''
          AND NOT EXISTS (SELECT 1 FROM content_translation ct
                           WHERE ct.table_name = 'component_video' AND ct.row_id = comp.id
                             AND ct.field_name = 'video_alt' AND ct.locale = p_locale)

        UNION ALL
        SELECT 'component_video', comp.id, 'video_description',
               CASE WHEN c.owner_type = 'module'
                    THEN CONCAT("Module '", m.title, "' (day ", m.day_number, '), card ', c.card_order_index)
                    ELSE CONCAT("Simulator '", s.title, "', card ", c.card_order_index) END,
               comp.video_description
        FROM component_video comp
        JOIN card_contains cc ON cc.component_id = comp.id AND cc.component_type = 'video'
        JOIN card c ON c.id = cc.card_id
        LEFT JOIN module m ON c.owner_type = 'module' AND m.id = c.owner_id
        LEFT JOIN simulator s ON c.owner_type = 'simulator' AND s.id = c.owner_id
        WHERE comp.video_description IS NOT NULL AND comp.video_description <> ''
          AND NOT EXISTS (SELECT 1 FROM content_translation ct
                           WHERE ct.table_name = 'component_video' AND ct.row_id = comp.id
                             AND ct.field_name = 'video_description' AND ct.locale = p_locale)

        -- component_mcq.question ----------------------------------------
        UNION ALL
        SELECT 'component_mcq', comp.id, 'question',
               CASE WHEN c.owner_type = 'module'
                    THEN CONCAT("Module '", m.title, "' (day ", m.day_number, '), card ', c.card_order_index)
                    ELSE CONCAT("Simulator '", s.title, "', card ", c.card_order_index) END,
               comp.question
        FROM component_mcq comp
        JOIN card_contains cc ON cc.component_id = comp.id AND cc.component_type = 'mcq'
        JOIN card c ON c.id = cc.card_id
        LEFT JOIN module m ON c.owner_type = 'module' AND m.id = c.owner_id
        LEFT JOIN simulator s ON c.owner_type = 'simulator' AND s.id = c.owner_id
        WHERE comp.question IS NOT NULL AND comp.question <> ''
          AND NOT EXISTS (SELECT 1 FROM content_translation ct
                           WHERE ct.table_name = 'component_mcq' AND ct.row_id = comp.id
                             AND ct.field_name = 'question' AND ct.locale = p_locale)

        -- multiple_choices_options (option_text / feedback) ------------
        UNION ALL
        SELECT 'multiple_choices_options', o.id, 'option_text',
               CASE WHEN c.owner_type = 'module'
                    THEN CONCAT("Module '", m.title, "' (day ", m.day_number, '), card ', c.card_order_index)
                    ELSE CONCAT("Simulator '", s.title, "', card ", c.card_order_index) END,
               o.option_text
        FROM multiple_choices_options o
        JOIN card_contains cc ON cc.component_id = o.mcq_id AND cc.component_type = 'mcq'
        JOIN card c ON c.id = cc.card_id
        LEFT JOIN module m ON c.owner_type = 'module' AND m.id = c.owner_id
        LEFT JOIN simulator s ON c.owner_type = 'simulator' AND s.id = c.owner_id
        WHERE o.option_text IS NOT NULL AND o.option_text <> ''
          AND NOT EXISTS (SELECT 1 FROM content_translation ct
                           WHERE ct.table_name = 'multiple_choices_options' AND ct.row_id = o.id
                             AND ct.field_name = 'option_text' AND ct.locale = p_locale)

        UNION ALL
        SELECT 'multiple_choices_options', o.id, 'feedback',
               CASE WHEN c.owner_type = 'module'
                    THEN CONCAT("Module '", m.title, "' (day ", m.day_number, '), card ', c.card_order_index)
                    ELSE CONCAT("Simulator '", s.title, "', card ", c.card_order_index) END,
               o.feedback
        FROM multiple_choices_options o
        JOIN card_contains cc ON cc.component_id = o.mcq_id AND cc.component_type = 'mcq'
        JOIN card c ON c.id = cc.card_id
        LEFT JOIN module m ON c.owner_type = 'module' AND m.id = c.owner_id
        LEFT JOIN simulator s ON c.owner_type = 'simulator' AND s.id = c.owner_id
        WHERE o.feedback IS NOT NULL AND o.feedback <> ''
          AND NOT EXISTS (SELECT 1 FROM content_translation ct
                           WHERE ct.table_name = 'multiple_choices_options' AND ct.row_id = o.id
                             AND ct.field_name = 'feedback' AND ct.locale = p_locale)

        -- component_open_questions.question (placeholder never used) --
        UNION ALL
        SELECT 'component_open_questions', comp.id, 'question',
               CASE WHEN c.owner_type = 'module'
                    THEN CONCAT("Module '", m.title, "' (day ", m.day_number, '), card ', c.card_order_index)
                    ELSE CONCAT("Simulator '", s.title, "', card ", c.card_order_index) END,
               comp.question
        FROM component_open_questions comp
        JOIN card_contains cc ON cc.component_id = comp.id AND cc.component_type = 'open question'
        JOIN card c ON c.id = cc.card_id
        LEFT JOIN module m ON c.owner_type = 'module' AND m.id = c.owner_id
        LEFT JOIN simulator s ON c.owner_type = 'simulator' AND s.id = c.owner_id
        WHERE comp.question IS NOT NULL AND comp.question <> ''
          AND NOT EXISTS (SELECT 1 FROM content_translation ct
                           WHERE ct.table_name = 'component_open_questions' AND ct.row_id = comp.id
                             AND ct.field_name = 'question' AND ct.locale = p_locale)

        -- component_list.content ----------------------------------------
        UNION ALL
        SELECT 'component_list', comp.id, 'content',
               CASE WHEN c.owner_type = 'module'
                    THEN CONCAT("Module '", m.title, "' (day ", m.day_number, '), card ', c.card_order_index)
                    ELSE CONCAT("Simulator '", s.title, "', card ", c.card_order_index) END,
               comp.content
        FROM component_list comp
        JOIN card_contains cc ON cc.component_id = comp.id AND cc.component_type = 'list'
        JOIN card c ON c.id = cc.card_id
        LEFT JOIN module m ON c.owner_type = 'module' AND m.id = c.owner_id
        LEFT JOIN simulator s ON c.owner_type = 'simulator' AND s.id = c.owner_id
        WHERE comp.content IS NOT NULL AND comp.content <> ''
          AND NOT EXISTS (SELECT 1 FROM content_translation ct
                           WHERE ct.table_name = 'component_list' AND ct.row_id = comp.id
                             AND ct.field_name = 'content' AND ct.locale = p_locale)

        -- component_last_messages.content -------------------------------
        UNION ALL
        SELECT 'component_last_messages', comp.id, 'content',
               CASE WHEN c.owner_type = 'module'
                    THEN CONCAT("Module '", m.title, "' (day ", m.day_number, '), card ', c.card_order_index)
                    ELSE CONCAT("Simulator '", s.title, "', card ", c.card_order_index) END,
               comp.content
        FROM component_last_messages comp
        JOIN card_contains cc ON cc.component_id = comp.id AND cc.component_type = 'last message'
        JOIN card c ON c.id = cc.card_id
        LEFT JOIN module m ON c.owner_type = 'module' AND m.id = c.owner_id
        LEFT JOIN simulator s ON c.owner_type = 'simulator' AND s.id = c.owner_id
        WHERE comp.content IS NOT NULL AND comp.content <> ''
          AND NOT EXISTS (SELECT 1 FROM content_translation ct
                           WHERE ct.table_name = 'component_last_messages' AND ct.row_id = comp.id
                             AND ct.field_name = 'content' AND ct.locale = p_locale)

        -- simulator_metric.name -------------------------------------------
        UNION ALL
        SELECT 'simulator_metric', sm.id, 'name',
               CONCAT("Metric '", sm.name, "'"),
               sm.name
        FROM simulator_metric sm
        WHERE sm.name IS NOT NULL AND sm.name <> ''
          AND NOT EXISTS (SELECT 1 FROM content_translation ct
                           WHERE ct.table_name = 'simulator_metric' AND ct.row_id = sm.id
                             AND ct.field_name = 'name' AND ct.locale = p_locale)

        -- simulator_feedback_tiers (strength / risk / practice / reason) --
        UNION ALL
        SELECT 'simulator_feedback_tiers', t.id, 'strength_result',
               CONCAT("Simulator '", s.title, "' feedback tier ", t.id, ' (metric ', t.metric_id, ')'),
               t.strength_result
        FROM simulator_feedback_tiers t
        JOIN simulator s ON s.id = t.simulator_id
        WHERE t.strength_result IS NOT NULL AND t.strength_result <> ''
          AND NOT EXISTS (SELECT 1 FROM content_translation ct
                           WHERE ct.table_name = 'simulator_feedback_tiers' AND ct.row_id = t.id
                             AND ct.field_name = 'strength_result' AND ct.locale = p_locale)

        UNION ALL
        SELECT 'simulator_feedback_tiers', t.id, 'risk_result',
               CONCAT("Simulator '", s.title, "' feedback tier ", t.id, ' (metric ', t.metric_id, ')'),
               t.risk_result
        FROM simulator_feedback_tiers t
        JOIN simulator s ON s.id = t.simulator_id
        WHERE t.risk_result IS NOT NULL AND t.risk_result <> ''
          AND NOT EXISTS (SELECT 1 FROM content_translation ct
                           WHERE ct.table_name = 'simulator_feedback_tiers' AND ct.row_id = t.id
                             AND ct.field_name = 'risk_result' AND ct.locale = p_locale)

        UNION ALL
        SELECT 'simulator_feedback_tiers', t.id, 'micro_practice',
               CONCAT("Simulator '", s.title, "' feedback tier ", t.id, ' (metric ', t.metric_id, ')'),
               t.micro_practice
        FROM simulator_feedback_tiers t
        JOIN simulator s ON s.id = t.simulator_id
        WHERE t.micro_practice IS NOT NULL AND t.micro_practice <> ''
          AND NOT EXISTS (SELECT 1 FROM content_translation ct
                           WHERE ct.table_name = 'simulator_feedback_tiers' AND ct.row_id = t.id
                             AND ct.field_name = 'micro_practice' AND ct.locale = p_locale)

        UNION ALL
        SELECT 'simulator_feedback_tiers', t.id, 'recommendation_reason',
               CONCAT("Simulator '", s.title, "' feedback tier ", t.id, ' (metric ', t.metric_id, ')'),
               t.recommendation_reason
        FROM simulator_feedback_tiers t
        JOIN simulator s ON s.id = t.simulator_id
        WHERE t.recommendation_reason IS NOT NULL AND t.recommendation_reason <> ''
          AND NOT EXISTS (SELECT 1 FROM content_translation ct
                           WHERE ct.table_name = 'simulator_feedback_tiers' AND ct.row_id = t.id
                             AND ct.field_name = 'recommendation_reason' AND ct.locale = p_locale)
    ;
END$$

DELIMITER ;

-- ============================================================
-- Public: full detail for one language.
-- ============================================================

DELIMITER $$

DROP PROCEDURE IF EXISTS sp_missing_translations$$

CREATE PROCEDURE sp_missing_translations(IN p_locale VARCHAR(10))
BEGIN
    CALL sp_refresh_missing_translations(p_locale);
    SELECT table_name, row_id, field_name, location, english_value
    FROM tmp_missing_translations
    ORDER BY table_name, row_id, field_name;
END$$

DELIMITER ;

-- ============================================================
-- Public: per-language summary counts only (no rows), handy to eyeball
-- progress across all four languages at once. Add/remove locales in the
-- CALL list below as more translation folders are added.
-- ============================================================

DELIMITER $$

DROP PROCEDURE IF EXISTS sp_missing_translations_summary$$

CREATE PROCEDURE sp_missing_translations_summary()
BEGIN
    DROP TEMPORARY TABLE IF EXISTS tmp_missing_summary;
    CREATE TEMPORARY TABLE tmp_missing_summary (locale VARCHAR(10), missing_count INT);

    CALL sp_refresh_missing_translations('pl');
    INSERT INTO tmp_missing_summary SELECT 'pl', COUNT(*) FROM tmp_missing_translations;

    CALL sp_refresh_missing_translations('nl');
    INSERT INTO tmp_missing_summary SELECT 'nl', COUNT(*) FROM tmp_missing_translations;

    CALL sp_refresh_missing_translations('cs');
    INSERT INTO tmp_missing_summary SELECT 'cs', COUNT(*) FROM tmp_missing_translations;

    CALL sp_refresh_missing_translations('el');
    INSERT INTO tmp_missing_summary SELECT 'el', COUNT(*) FROM tmp_missing_translations;

    SELECT * FROM tmp_missing_summary ORDER BY missing_count DESC;
END$$

DELIMITER ;
