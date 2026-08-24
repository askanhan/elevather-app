-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:06.923883
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Course: Ikigai: Discover your purpose
-- ============================================

-- Category: General
-- Check/Create category 'General'
INSERT IGNORE INTO module_category (title, description, created_at) VALUES ('General', 'test description', '2026-08-23 19:54:06.921120');

-- Module creation with automatic category lookup
INSERT INTO module (module_category_id, day_number, title, description, target_audience, estimated_duration, created_at) VALUES ((SELECT id FROM module_category WHERE title = 'General'), 4, 'Ikigai: Discover your purpose', 'Explore Ikigai - the intersection of what you love, what you’re good at, what the world needs and pays for - this reflective journey helps you uncover your true purpose, align your career with your values, and lead a life filled with meaning and fulfillment.', 'women learners', 0, '2026-08-23 19:54:06.921130');

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Ikigai: Discover your purpose'), 1, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Ikigai: Discover your purpose'), 2, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Ikigai: Discover your purpose'), 3, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Ikigai: Discover your purpose'), 4, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Ikigai: Discover your purpose'), 5, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 6
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Ikigai: Discover your purpose'), 6, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 7
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Ikigai: Discover your purpose'), 7, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 8
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Ikigai: Discover your purpose'), 8, NULL, NULL, NULL, NULL);

-- ============================================
-- End of generated queries
-- ============================================
