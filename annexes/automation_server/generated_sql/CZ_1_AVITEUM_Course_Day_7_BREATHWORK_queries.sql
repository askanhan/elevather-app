-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:06.956348
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Course: Breathwork for Focus and Balance
-- ============================================

-- Category: General
-- Check/Create category 'General'
INSERT IGNORE INTO module_category (title, description, created_at) VALUES ('General', 'test description', '2026-08-23 19:54:06.953821');

-- Module creation with automatic category lookup
INSERT INTO module (module_category_id, day_number, title, description, target_audience, estimated_duration, created_at) VALUES ((SELECT id FROM module_category WHERE title = 'General'), 7, 'Breathwork for Focus and Balance', 'Harness the power of your breath to calm the mind, sharpen focus, and energise your body. Through guided breathing techniques, learn to manage stress, boost clarity, and lead with greater presence and emotional stability.', 'women learners', 0, '2026-08-23 19:54:06.953832');

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Breathwork for Focus and Balance'), 1, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Breathwork for Focus and Balance'), 2, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Breathwork for Focus and Balance'), 3, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Breathwork for Focus and Balance'), 4, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Breathwork for Focus and Balance'), 5, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 6
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Breathwork for Focus and Balance'), 6, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 7
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Breathwork for Focus and Balance'), 7, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 8
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Breathwork for Focus and Balance'), 8, NULL, NULL, NULL, NULL);

-- ============================================
-- End of generated queries
-- ============================================
