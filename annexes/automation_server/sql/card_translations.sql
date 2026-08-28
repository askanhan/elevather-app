-- For a given locale, lists every card together with the base (English)
-- value and the translated value of every translatable field reachable
-- from that card: the card's own fields (title/subtitle/end_text/
-- why_this_question), every component attached to it via card_contains,
-- and every MCQ answer option belonging to a component_mcq on that card.
--
-- Load once:
--   mysql -h localhost -u root elevather < sql/card_translations.sql
--
-- Then call:
--   CALL sp_card_translations('pl', NULL);       -- every card
--   CALL sp_card_translations('pl', 42);          -- just card id 42
--   CALL sp_card_translations_summary('pl');      -- one row per card: fields translated / total

DROP PROCEDURE IF EXISTS sp_card_translations;
DROP PROCEDURE IF EXISTS sp_card_translations_summary;
DROP PROCEDURE IF EXISTS sp_refresh_card_translations;

DELIMITER $$

-- MySQL forbids referencing the same TEMPORARY table more than once inside
-- one statement ("Can't reopen table"), so the module/simulator context for
-- each card is computed inline via LEFT JOIN in every branch below instead
-- of being cached in a shared temp table.
CREATE PROCEDURE sp_refresh_card_translations(IN p_locale VARCHAR(10))
BEGIN
    DROP TEMPORARY TABLE IF EXISTS tmp_card_translations;
    CREATE TEMPORARY TABLE tmp_card_translations (
        card_id INT,
        location VARCHAR(500),
        card_order_index INT,
        component_order_index INT,
        component_type VARCHAR(30),
        component_id INT,
        field_name VARCHAR(50),
        base_value TEXT,
        translated_value TEXT
    );

    -- 1) The card's own fields
    INSERT INTO tmp_card_translations
    SELECT c.id,
           CASE WHEN c.owner_type = 'module' THEN CONCAT("Module '", m.title, "' (day ", m.day_number, "), card ", c.card_order_index)
                WHEN c.owner_type = 'simulator' THEN CONCAT("Simulator '", s.title, "', card ", c.card_order_index)
                ELSE CONCAT(c.owner_type, ' ', c.owner_id, ', card ', c.card_order_index) END,
           c.card_order_index, -1, 'card', c.id, 'title', c.title, ct.value
    FROM card c
    LEFT JOIN module m ON c.owner_type = 'module' AND c.owner_id = m.id
    LEFT JOIN simulator s ON c.owner_type = 'simulator' AND c.owner_id = s.id
    LEFT JOIN content_translation ct ON ct.table_name = 'card' AND ct.row_id = c.id
                                     AND ct.field_name = 'title' AND ct.locale = p_locale
    WHERE c.title IS NOT NULL AND c.title <> ''
    UNION ALL
    SELECT c.id,
           CASE WHEN c.owner_type = 'module' THEN CONCAT("Module '", m.title, "' (day ", m.day_number, "), card ", c.card_order_index)
                WHEN c.owner_type = 'simulator' THEN CONCAT("Simulator '", s.title, "', card ", c.card_order_index)
                ELSE CONCAT(c.owner_type, ' ', c.owner_id, ', card ', c.card_order_index) END,
           c.card_order_index, -1, 'card', c.id, 'subtitle', c.subtitle, ct.value
    FROM card c
    LEFT JOIN module m ON c.owner_type = 'module' AND c.owner_id = m.id
    LEFT JOIN simulator s ON c.owner_type = 'simulator' AND c.owner_id = s.id
    LEFT JOIN content_translation ct ON ct.table_name = 'card' AND ct.row_id = c.id
                                     AND ct.field_name = 'subtitle' AND ct.locale = p_locale
    WHERE c.subtitle IS NOT NULL AND c.subtitle <> ''
    UNION ALL
    SELECT c.id,
           CASE WHEN c.owner_type = 'module' THEN CONCAT("Module '", m.title, "' (day ", m.day_number, "), card ", c.card_order_index)
                WHEN c.owner_type = 'simulator' THEN CONCAT("Simulator '", s.title, "', card ", c.card_order_index)
                ELSE CONCAT(c.owner_type, ' ', c.owner_id, ', card ', c.card_order_index) END,
           c.card_order_index, -1, 'card', c.id, 'end_text', c.end_text, ct.value
    FROM card c
    LEFT JOIN module m ON c.owner_type = 'module' AND c.owner_id = m.id
    LEFT JOIN simulator s ON c.owner_type = 'simulator' AND c.owner_id = s.id
    LEFT JOIN content_translation ct ON ct.table_name = 'card' AND ct.row_id = c.id
                                     AND ct.field_name = 'end_text' AND ct.locale = p_locale
    WHERE c.end_text IS NOT NULL AND c.end_text <> ''
    UNION ALL
    SELECT c.id,
           CASE WHEN c.owner_type = 'module' THEN CONCAT("Module '", m.title, "' (day ", m.day_number, "), card ", c.card_order_index)
                WHEN c.owner_type = 'simulator' THEN CONCAT("Simulator '", s.title, "', card ", c.card_order_index)
                ELSE CONCAT(c.owner_type, ' ', c.owner_id, ', card ', c.card_order_index) END,
           c.card_order_index, -1, 'card', c.id, 'why_this_question', c.why_this_question, ct.value
    FROM card c
    LEFT JOIN module m ON c.owner_type = 'module' AND c.owner_id = m.id
    LEFT JOIN simulator s ON c.owner_type = 'simulator' AND c.owner_id = s.id
    LEFT JOIN content_translation ct ON ct.table_name = 'card' AND ct.row_id = c.id
                                     AND ct.field_name = 'why_this_question' AND ct.locale = p_locale
    WHERE c.why_this_question IS NOT NULL AND c.why_this_question <> '';

    -- 2) Simple single-field component types reachable via card_contains
    INSERT INTO tmp_card_translations
    SELECT cc.card_id,
           CASE WHEN c.owner_type = 'module' THEN CONCAT("Module '", m.title, "' (day ", m.day_number, "), card ", c.card_order_index)
                WHEN c.owner_type = 'simulator' THEN CONCAT("Simulator '", s.title, "', card ", c.card_order_index)
                ELSE CONCAT(c.owner_type, ' ', c.owner_id, ', card ', c.card_order_index) END,
           c.card_order_index, cc.component_order_index, cc.component_type, cc.component_id, 'content', x.content, ct.value
    FROM card_contains cc
    JOIN card c ON c.id = cc.card_id
    LEFT JOIN module m ON c.owner_type = 'module' AND c.owner_id = m.id
    LEFT JOIN simulator s ON c.owner_type = 'simulator' AND c.owner_id = s.id
    JOIN component_title x ON cc.component_type = 'title' AND x.id = cc.component_id
    LEFT JOIN content_translation ct ON ct.table_name = 'component_title' AND ct.row_id = x.id
                                     AND ct.field_name = 'content' AND ct.locale = p_locale
    UNION ALL
    SELECT cc.card_id,
           CASE WHEN c.owner_type = 'module' THEN CONCAT("Module '", m.title, "' (day ", m.day_number, "), card ", c.card_order_index)
                WHEN c.owner_type = 'simulator' THEN CONCAT("Simulator '", s.title, "', card ", c.card_order_index)
                ELSE CONCAT(c.owner_type, ' ', c.owner_id, ', card ', c.card_order_index) END,
           c.card_order_index, cc.component_order_index, cc.component_type, cc.component_id, 'content', x.content, ct.value
    FROM card_contains cc
    JOIN card c ON c.id = cc.card_id
    LEFT JOIN module m ON c.owner_type = 'module' AND c.owner_id = m.id
    LEFT JOIN simulator s ON c.owner_type = 'simulator' AND c.owner_id = s.id
    JOIN component_subtitle x ON cc.component_type = 'subtitle' AND x.id = cc.component_id
    LEFT JOIN content_translation ct ON ct.table_name = 'component_subtitle' AND ct.row_id = x.id
                                     AND ct.field_name = 'content' AND ct.locale = p_locale
    UNION ALL
    SELECT cc.card_id,
           CASE WHEN c.owner_type = 'module' THEN CONCAT("Module '", m.title, "' (day ", m.day_number, "), card ", c.card_order_index)
                WHEN c.owner_type = 'simulator' THEN CONCAT("Simulator '", s.title, "', card ", c.card_order_index)
                ELSE CONCAT(c.owner_type, ' ', c.owner_id, ', card ', c.card_order_index) END,
           c.card_order_index, cc.component_order_index, cc.component_type, cc.component_id, 'content', x.content, ct.value
    FROM card_contains cc
    JOIN card c ON c.id = cc.card_id
    LEFT JOIN module m ON c.owner_type = 'module' AND c.owner_id = m.id
    LEFT JOIN simulator s ON c.owner_type = 'simulator' AND c.owner_id = s.id
    JOIN component_text x ON cc.component_type = 'text' AND x.id = cc.component_id
    LEFT JOIN content_translation ct ON ct.table_name = 'component_text' AND ct.row_id = x.id
                                     AND ct.field_name = 'content' AND ct.locale = p_locale
    UNION ALL
    SELECT cc.card_id,
           CASE WHEN c.owner_type = 'module' THEN CONCAT("Module '", m.title, "' (day ", m.day_number, "), card ", c.card_order_index)
                WHEN c.owner_type = 'simulator' THEN CONCAT("Simulator '", s.title, "', card ", c.card_order_index)
                ELSE CONCAT(c.owner_type, ' ', c.owner_id, ', card ', c.card_order_index) END,
           c.card_order_index, cc.component_order_index, cc.component_type, cc.component_id, 'content', x.content, ct.value
    FROM card_contains cc
    JOIN card c ON c.id = cc.card_id
    LEFT JOIN module m ON c.owner_type = 'module' AND c.owner_id = m.id
    LEFT JOIN simulator s ON c.owner_type = 'simulator' AND c.owner_id = s.id
    JOIN component_list x ON cc.component_type = 'list' AND x.id = cc.component_id
    LEFT JOIN content_translation ct ON ct.table_name = 'component_list' AND ct.row_id = x.id
                                     AND ct.field_name = 'content' AND ct.locale = p_locale
    UNION ALL
    SELECT cc.card_id,
           CASE WHEN c.owner_type = 'module' THEN CONCAT("Module '", m.title, "' (day ", m.day_number, "), card ", c.card_order_index)
                WHEN c.owner_type = 'simulator' THEN CONCAT("Simulator '", s.title, "', card ", c.card_order_index)
                ELSE CONCAT(c.owner_type, ' ', c.owner_id, ', card ', c.card_order_index) END,
           c.card_order_index, cc.component_order_index, cc.component_type, cc.component_id, 'content', x.content, ct.value
    FROM card_contains cc
    JOIN card c ON c.id = cc.card_id
    LEFT JOIN module m ON c.owner_type = 'module' AND c.owner_id = m.id
    LEFT JOIN simulator s ON c.owner_type = 'simulator' AND c.owner_id = s.id
    JOIN component_last_messages x ON cc.component_type = 'last message' AND x.id = cc.component_id
    LEFT JOIN content_translation ct ON ct.table_name = 'component_last_messages' AND ct.row_id = x.id
                                     AND ct.field_name = 'content' AND ct.locale = p_locale
    UNION ALL
    SELECT cc.card_id,
           CASE WHEN c.owner_type = 'module' THEN CONCAT("Module '", m.title, "' (day ", m.day_number, "), card ", c.card_order_index)
                WHEN c.owner_type = 'simulator' THEN CONCAT("Simulator '", s.title, "', card ", c.card_order_index)
                ELSE CONCAT(c.owner_type, ' ', c.owner_id, ', card ', c.card_order_index) END,
           c.card_order_index, cc.component_order_index, cc.component_type, cc.component_id, 'question', x.question, ct.value
    FROM card_contains cc
    JOIN card c ON c.id = cc.card_id
    LEFT JOIN module m ON c.owner_type = 'module' AND c.owner_id = m.id
    LEFT JOIN simulator s ON c.owner_type = 'simulator' AND c.owner_id = s.id
    JOIN component_mcq x ON cc.component_type = 'mcq' AND x.id = cc.component_id
    LEFT JOIN content_translation ct ON ct.table_name = 'component_mcq' AND ct.row_id = x.id
                                     AND ct.field_name = 'question' AND ct.locale = p_locale
    UNION ALL
    SELECT cc.card_id,
           CASE WHEN c.owner_type = 'module' THEN CONCAT("Module '", m.title, "' (day ", m.day_number, "), card ", c.card_order_index)
                WHEN c.owner_type = 'simulator' THEN CONCAT("Simulator '", s.title, "', card ", c.card_order_index)
                ELSE CONCAT(c.owner_type, ' ', c.owner_id, ', card ', c.card_order_index) END,
           c.card_order_index, cc.component_order_index, cc.component_type, cc.component_id, 'question', x.question, ct.value
    FROM card_contains cc
    JOIN card c ON c.id = cc.card_id
    LEFT JOIN module m ON c.owner_type = 'module' AND c.owner_id = m.id
    LEFT JOIN simulator s ON c.owner_type = 'simulator' AND c.owner_id = s.id
    JOIN component_open_questions x ON cc.component_type = 'open question' AND x.id = cc.component_id
    LEFT JOIN content_translation ct ON ct.table_name = 'component_open_questions' AND ct.row_id = x.id
                                     AND ct.field_name = 'question' AND ct.locale = p_locale
    UNION ALL
    SELECT cc.card_id,
           CASE WHEN c.owner_type = 'module' THEN CONCAT("Module '", m.title, "' (day ", m.day_number, "), card ", c.card_order_index)
                WHEN c.owner_type = 'simulator' THEN CONCAT("Simulator '", s.title, "', card ", c.card_order_index)
                ELSE CONCAT(c.owner_type, ' ', c.owner_id, ', card ', c.card_order_index) END,
           c.card_order_index, cc.component_order_index, cc.component_type, cc.component_id, 'content', x.content, ct.value
    FROM card_contains cc
    JOIN card c ON c.id = cc.card_id
    LEFT JOIN module m ON c.owner_type = 'module' AND c.owner_id = m.id
    LEFT JOIN simulator s ON c.owner_type = 'simulator' AND c.owner_id = s.id
    JOIN component_quote x ON cc.component_type = 'quote' AND x.id = cc.component_id
    LEFT JOIN content_translation ct ON ct.table_name = 'component_quote' AND ct.row_id = x.id
                                     AND ct.field_name = 'content' AND ct.locale = p_locale
    UNION ALL
    SELECT cc.card_id,
           CASE WHEN c.owner_type = 'module' THEN CONCAT("Module '", m.title, "' (day ", m.day_number, "), card ", c.card_order_index)
                WHEN c.owner_type = 'simulator' THEN CONCAT("Simulator '", s.title, "', card ", c.card_order_index)
                ELSE CONCAT(c.owner_type, ' ', c.owner_id, ', card ', c.card_order_index) END,
           c.card_order_index, cc.component_order_index, cc.component_type, cc.component_id, 'author', x.author, ct.value
    FROM card_contains cc
    JOIN card c ON c.id = cc.card_id
    LEFT JOIN module m ON c.owner_type = 'module' AND c.owner_id = m.id
    LEFT JOIN simulator s ON c.owner_type = 'simulator' AND c.owner_id = s.id
    JOIN component_quote x ON cc.component_type = 'quote' AND x.id = cc.component_id
    LEFT JOIN content_translation ct ON ct.table_name = 'component_quote' AND ct.row_id = x.id
                                     AND ct.field_name = 'author' AND ct.locale = p_locale
    WHERE x.author IS NOT NULL AND x.author <> '';

    -- 3) Two-field component types: image and video
    INSERT INTO tmp_card_translations
    SELECT cc.card_id,
           CASE WHEN c.owner_type = 'module' THEN CONCAT("Module '", m.title, "' (day ", m.day_number, "), card ", c.card_order_index)
                WHEN c.owner_type = 'simulator' THEN CONCAT("Simulator '", s.title, "', card ", c.card_order_index)
                ELSE CONCAT(c.owner_type, ' ', c.owner_id, ', card ', c.card_order_index) END,
           c.card_order_index, cc.component_order_index, cc.component_type, cc.component_id, 'image_alt', x.image_alt, ct.value
    FROM card_contains cc
    JOIN card c ON c.id = cc.card_id
    LEFT JOIN module m ON c.owner_type = 'module' AND c.owner_id = m.id
    LEFT JOIN simulator s ON c.owner_type = 'simulator' AND c.owner_id = s.id
    JOIN component_image x ON cc.component_type = 'image' AND x.id = cc.component_id
    LEFT JOIN content_translation ct ON ct.table_name = 'component_image' AND ct.row_id = x.id
                                     AND ct.field_name = 'image_alt' AND ct.locale = p_locale
    WHERE x.image_alt IS NOT NULL AND x.image_alt <> ''
    UNION ALL
    SELECT cc.card_id,
           CASE WHEN c.owner_type = 'module' THEN CONCAT("Module '", m.title, "' (day ", m.day_number, "), card ", c.card_order_index)
                WHEN c.owner_type = 'simulator' THEN CONCAT("Simulator '", s.title, "', card ", c.card_order_index)
                ELSE CONCAT(c.owner_type, ' ', c.owner_id, ', card ', c.card_order_index) END,
           c.card_order_index, cc.component_order_index, cc.component_type, cc.component_id, 'image_description', x.image_description, ct.value
    FROM card_contains cc
    JOIN card c ON c.id = cc.card_id
    LEFT JOIN module m ON c.owner_type = 'module' AND c.owner_id = m.id
    LEFT JOIN simulator s ON c.owner_type = 'simulator' AND c.owner_id = s.id
    JOIN component_image x ON cc.component_type = 'image' AND x.id = cc.component_id
    LEFT JOIN content_translation ct ON ct.table_name = 'component_image' AND ct.row_id = x.id
                                     AND ct.field_name = 'image_description' AND ct.locale = p_locale
    WHERE x.image_description IS NOT NULL AND x.image_description <> ''
    UNION ALL
    SELECT cc.card_id,
           CASE WHEN c.owner_type = 'module' THEN CONCAT("Module '", m.title, "' (day ", m.day_number, "), card ", c.card_order_index)
                WHEN c.owner_type = 'simulator' THEN CONCAT("Simulator '", s.title, "', card ", c.card_order_index)
                ELSE CONCAT(c.owner_type, ' ', c.owner_id, ', card ', c.card_order_index) END,
           c.card_order_index, cc.component_order_index, cc.component_type, cc.component_id, 'video_alt', x.video_alt, ct.value
    FROM card_contains cc
    JOIN card c ON c.id = cc.card_id
    LEFT JOIN module m ON c.owner_type = 'module' AND c.owner_id = m.id
    LEFT JOIN simulator s ON c.owner_type = 'simulator' AND c.owner_id = s.id
    JOIN component_video x ON cc.component_type = 'video' AND x.id = cc.component_id
    LEFT JOIN content_translation ct ON ct.table_name = 'component_video' AND ct.row_id = x.id
                                     AND ct.field_name = 'video_alt' AND ct.locale = p_locale
    WHERE x.video_alt IS NOT NULL AND x.video_alt <> ''
    UNION ALL
    SELECT cc.card_id,
           CASE WHEN c.owner_type = 'module' THEN CONCAT("Module '", m.title, "' (day ", m.day_number, "), card ", c.card_order_index)
                WHEN c.owner_type = 'simulator' THEN CONCAT("Simulator '", s.title, "', card ", c.card_order_index)
                ELSE CONCAT(c.owner_type, ' ', c.owner_id, ', card ', c.card_order_index) END,
           c.card_order_index, cc.component_order_index, cc.component_type, cc.component_id, 'video_description', x.video_description, ct.value
    FROM card_contains cc
    JOIN card c ON c.id = cc.card_id
    LEFT JOIN module m ON c.owner_type = 'module' AND c.owner_id = m.id
    LEFT JOIN simulator s ON c.owner_type = 'simulator' AND c.owner_id = s.id
    JOIN component_video x ON cc.component_type = 'video' AND x.id = cc.component_id
    LEFT JOIN content_translation ct ON ct.table_name = 'component_video' AND ct.row_id = x.id
                                     AND ct.field_name = 'video_description' AND ct.locale = p_locale
    WHERE x.video_description IS NOT NULL AND x.video_description <> '';

    -- 4) MCQ answer options - children of component_mcq, reached through card_contains indirectly
    INSERT INTO tmp_card_translations
    SELECT cc.card_id,
           CASE WHEN c.owner_type = 'module' THEN CONCAT("Module '", m.title, "' (day ", m.day_number, "), card ", c.card_order_index)
                WHEN c.owner_type = 'simulator' THEN CONCAT("Simulator '", s.title, "', card ", c.card_order_index)
                ELSE CONCAT(c.owner_type, ' ', c.owner_id, ', card ', c.card_order_index) END,
           c.card_order_index, cc.component_order_index, 'mcq_option', o.id, 'option_text', o.option_text, ct.value
    FROM card_contains cc
    JOIN card c ON c.id = cc.card_id
    LEFT JOIN module m ON c.owner_type = 'module' AND c.owner_id = m.id
    LEFT JOIN simulator s ON c.owner_type = 'simulator' AND c.owner_id = s.id
    JOIN multiple_choices_options o ON cc.component_type = 'mcq' AND o.mcq_id = cc.component_id
    LEFT JOIN content_translation ct ON ct.table_name = 'multiple_choices_options' AND ct.row_id = o.id
                                     AND ct.field_name = 'option_text' AND ct.locale = p_locale
    UNION ALL
    SELECT cc.card_id,
           CASE WHEN c.owner_type = 'module' THEN CONCAT("Module '", m.title, "' (day ", m.day_number, "), card ", c.card_order_index)
                WHEN c.owner_type = 'simulator' THEN CONCAT("Simulator '", s.title, "', card ", c.card_order_index)
                ELSE CONCAT(c.owner_type, ' ', c.owner_id, ', card ', c.card_order_index) END,
           c.card_order_index, cc.component_order_index, 'mcq_option', o.id, 'feedback', o.feedback, ct.value
    FROM card_contains cc
    JOIN card c ON c.id = cc.card_id
    LEFT JOIN module m ON c.owner_type = 'module' AND c.owner_id = m.id
    LEFT JOIN simulator s ON c.owner_type = 'simulator' AND c.owner_id = s.id
    JOIN multiple_choices_options o ON cc.component_type = 'mcq' AND o.mcq_id = cc.component_id
    LEFT JOIN content_translation ct ON ct.table_name = 'multiple_choices_options' AND ct.row_id = o.id
                                     AND ct.field_name = 'feedback' AND ct.locale = p_locale
    WHERE o.feedback IS NOT NULL AND o.feedback <> '';
END$$

CREATE PROCEDURE sp_card_translations(IN p_locale VARCHAR(10), IN p_card_id INT)
BEGIN
    CALL sp_refresh_card_translations(p_locale);
    SELECT card_id, location, component_order_index, component_type, component_id,
           field_name, base_value,
           translated_value,
           CASE WHEN translated_value IS NULL THEN 'MISSING' ELSE 'OK' END AS status
    FROM tmp_card_translations
    WHERE p_card_id IS NULL OR card_id = p_card_id
    ORDER BY card_id, component_order_index, field_name;
    DROP TEMPORARY TABLE IF EXISTS tmp_card_translations;
END$$

CREATE PROCEDURE sp_card_translations_summary(IN p_locale VARCHAR(10))
BEGIN
    CALL sp_refresh_card_translations(p_locale);
    SELECT card_id, ANY_VALUE(location) AS location,
           COUNT(*) AS total_fields,
           SUM(translated_value IS NOT NULL) AS translated_fields,
           SUM(translated_value IS NULL) AS missing_fields
    FROM tmp_card_translations
    GROUP BY card_id
    ORDER BY missing_fields DESC, card_id;
    DROP TEMPORARY TABLE IF EXISTS tmp_card_translations;
END$$

DELIMITER ;
