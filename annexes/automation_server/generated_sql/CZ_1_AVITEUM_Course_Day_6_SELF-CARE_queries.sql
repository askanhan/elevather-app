-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:06.856357
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Course: Self-Care for Strong Leaders
-- ============================================

-- Category: General
-- Check/Create category 'General'
INSERT IGNORE INTO module_category (title, description, created_at) VALUES ('General', 'test description', '2026-08-23 19:54:06.853963');

-- Module creation with automatic category lookup
INSERT INTO module (module_category_id, day_number, title, description, target_audience, estimated_duration, created_at) VALUES ((SELECT id FROM module_category WHERE title = 'General'), 6, 'Self-Care for Strong Leaders', 'Discover the power of self-care as a leadership tool – this practical journey helps you recharge your energy, strengthen your confidence, and build sustainable habits that allow you to live and lead with clarity, balance, and impact.', 'women learners', 0, '2026-08-23 19:54:06.853974');

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Self-Care for Strong Leaders'), 1, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Self-Care for Strong Leaders'), 2, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Self-Care for Strong Leaders'), 3, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Self-Care for Strong Leaders'), 4, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Self-Care for Strong Leaders'), 5, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 6
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Self-Care for Strong Leaders'), 6, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 7
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Self-Care for Strong Leaders'), 7, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 8
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Self-Care for Strong Leaders'), 8, NULL, NULL, NULL, NULL);

-- ============================================
-- End of generated queries
-- ============================================
