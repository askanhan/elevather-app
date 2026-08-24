-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:06.888932
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Course: Personal Brand Building: Lead With Your Story
-- ============================================

-- Category: General
-- Check/Create category 'General'
INSERT IGNORE INTO module_category (title, description, created_at) VALUES ('General', 'test description', '2026-08-23 19:54:06.886573');

-- Module creation with automatic category lookup
INSERT INTO module (module_category_id, day_number, title, description, target_audience, estimated_duration, created_at) VALUES ((SELECT id FROM module_category WHERE title = 'General'), 13, 'Personal Brand Building: Lead With Your Story', 'Discover how to define and express your unique value. Learn to craft an authentic personal narrative that attracts opportunities and inspires your community.', 'women learners', 0, '2026-08-23 19:54:06.886583');

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Personal Brand Building: Lead With Your Story'), 1, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Personal Brand Building: Lead With Your Story'), 2, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Personal Brand Building: Lead With Your Story'), 3, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Personal Brand Building: Lead With Your Story'), 4, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Personal Brand Building: Lead With Your Story'), 5, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 6
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Personal Brand Building: Lead With Your Story'), 6, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 7
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Personal Brand Building: Lead With Your Story'), 7, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 8
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Personal Brand Building: Lead With Your Story'), 8, NULL, NULL, NULL, NULL);

-- ============================================
-- End of generated queries
-- ============================================
