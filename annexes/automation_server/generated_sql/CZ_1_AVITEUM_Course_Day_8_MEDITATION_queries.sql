-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:07.029556
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Course: Mindful Meditation Moments
-- ============================================

-- Category: General
-- Check/Create category 'General'
INSERT IGNORE INTO module_category (title, description, created_at) VALUES ('General', 'test description', '2026-08-23 19:54:07.026998');

-- Module creation with automatic category lookup
INSERT INTO module (module_category_id, day_number, title, description, target_audience, estimated_duration, created_at) VALUES ((SELECT id FROM module_category WHERE title = 'General'), 8, 'Mindful Meditation Moments', 'Give yourself space to slow down and reconnect through a guided journey towards mindful moments. Nurture your inner strength and awareness so you can approach each decision and interaction with clarity and confidence.', 'women learners', 0, '2026-08-23 19:54:07.027005');

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Mindful Meditation Moments'), 1, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Mindful Meditation Moments'), 2, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Mindful Meditation Moments'), 3, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Mindful Meditation Moments'), 4, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Mindful Meditation Moments'), 5, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 6
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Mindful Meditation Moments'), 6, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 7
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Mindful Meditation Moments'), 7, NULL, NULL, NULL, NULL);

-- ============================================
-- Card 8
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Mindful Meditation Moments'), 8, NULL, NULL, NULL, NULL);

-- ============================================
-- End of generated queries
-- ============================================
