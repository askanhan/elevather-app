-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:06.715996
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Course: Vision, Confidence & Moving Forward
-- ============================================

-- Category: Leadership & Personal Growth
-- Check/Create category 'Leadership & Personal Growth'
INSERT IGNORE INTO module_category (title, description, created_at) VALUES ('Leadership & Personal Growth', 'test description', '2026-08-23 19:54:06.713149');

-- Module creation with automatic category lookup
INSERT INTO module (module_category_id, day_number, title, description, target_audience, estimated_duration, created_at) VALUES ((SELECT id FROM module_category WHERE title = 'Leadership & Personal Growth'), 18, 'Vision, Confidence & Moving Forward', 'Reflect on what matters to you, recognise your progress, and move forward with greater purpose and confidence.', 'women learners', 10, '2026-08-23 19:54:06.713159');

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward'), 1, 'Vision, Confidence & Moving Forward', NULL, NULL, NULL);

-- Component 1 for Card 1
INSERT INTO component_title (content) VALUES ('Vision, Confidence & Moving Forward');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Vision, Confidence & Moving Forward' AND owner_id = (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 1
INSERT INTO component_video (video_url, video_duration_est, video_alt, video_description) VALUES ('https://drive.google.com/file/d/1pHMrQ3atYFTgKerG2_5fQcBCrEMKbiqE/view?usp=drive_link', NULL, NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Vision, Confidence & Moving Forward' AND owner_id = (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward') LIMIT 1), 'video', 2, LAST_INSERT_ID());

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward'), 2, 'What Vision Really Means', NULL, NULL, NULL);

-- Component 1 for Card 2
INSERT INTO component_title (content) VALUES ('What Vision Really Means');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What Vision Really Means' AND owner_id = (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 2
INSERT INTO component_text (content) VALUES ('Vision is not about having a perfect plan.

It is about having a sense of direction — knowing what matters to you and what you want to move toward.

A clear direction can help you make choices, stay focused, and keep going when things feel uncertain.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What Vision Really Means' AND owner_id = (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward'), 3, 'What Matters to You?', NULL, NULL, NULL);

-- Component 1 for Card 3
INSERT INTO component_title (content) VALUES ('What Matters to You?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What Matters to You?' AND owner_id = (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 3
INSERT INTO component_text (content) VALUES ('Take a moment to think about what feels truly important to you right now.

What do you want more of in your life, your work, or the way you move through the world?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What Matters to You?' AND owner_id = (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 3
INSERT INTO component_open_questions (question) VALUES ('What matters most to you at this point in your journey?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What Matters to You?' AND owner_id = (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward') LIMIT 1), 'open question', 3, LAST_INSERT_ID());

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward'), 4, 'Confidence Grows with Progress', NULL, NULL, NULL);

-- Component 1 for Card 4
INSERT INTO component_title (content) VALUES ('Confidence Grows with Progress');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Confidence Grows with Progress' AND owner_id = (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 4
INSERT INTO component_text (content) VALUES ('Confidence does not always come first.

Often, it grows when you notice what you have already done, what you have learned, and how far you have come.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Confidence Grows with Progress' AND owner_id = (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward'), 5, 'What Helps You Move Forward?', NULL, NULL, NULL);

-- Component 1 for Card 5
INSERT INTO component_title (content) VALUES ('What Helps You Move Forward?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What Helps You Move Forward?' AND owner_id = (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 5
INSERT INTO component_mcq (question) VALUES ('You are feeling uncertain about your next step.

What is most helpful?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You are feeling uncertain about your next step.

What is most helpful?' ORDER BY id DESC LIMIT 1), 'Remind yourself what matters to you and choose one step forward');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You are feeling uncertain about your next step.

What is most helpful?' ORDER BY id DESC LIMIT 1), 'Compare yourself to others and see what they are doing');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You are feeling uncertain about your next step.

What is most helpful?' ORDER BY id DESC LIMIT 1), 'Wait until everything feels completely clear');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What Helps You Move Forward?' AND owner_id = (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward') LIMIT 1), 'mcq', 2, LAST_INSERT_ID());

-- Component 3 for Card 5
INSERT INTO component_last_messages (content) VALUES ('You do not need to have everything figured out to move forward.

A sense of direction, combined with one small step, can help you move ahead with more confidence.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What Helps You Move Forward?' AND owner_id = (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward') LIMIT 1), 'last message', 3, LAST_INSERT_ID());

-- ============================================
-- Card 6
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward'), 6, 'Notice What You’ve Already Done', NULL, NULL, NULL);

-- Component 1 for Card 6
INSERT INTO component_title (content) VALUES ('Notice What You’ve Already Done');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Notice What You’ve Already Done' AND owner_id = (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 6
INSERT INTO component_text (content) VALUES ('Sometimes, we focus so much on what is still ahead that we forget to notice our progress.

Looking back at what you have already done can help you recognise your strengths and move forward with more confidence.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Notice What You’ve Already Done' AND owner_id = (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 6
INSERT INTO component_open_questions (question) VALUES ('What is one thing you have done, learned, or overcome that reminds you of your progress?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Notice What You’ve Already Done' AND owner_id = (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward') LIMIT 1), 'open question', 3, LAST_INSERT_ID());

-- ============================================
-- Card 7
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward'), 7, 'Where Do You Want to Go Next?', NULL, NULL, NULL);

-- Component 1 for Card 7
INSERT INTO component_title (content) VALUES ('Where Do You Want to Go Next?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Where Do You Want to Go Next?' AND owner_id = (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 7
INSERT INTO component_text (content) VALUES ('Now that you have reflected on what matters to you and how far you have already come, think about what you want to move toward next.

It does not have to be a perfect answer — just a direction that feels meaningful to you.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Where Do You Want to Go Next?' AND owner_id = (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 7
INSERT INTO component_open_questions (question) VALUES ('What is one direction, goal, or area of growth you want to move toward next?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Where Do You Want to Go Next?' AND owner_id = (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward') LIMIT 1), 'open question', 3, LAST_INSERT_ID());

-- ============================================
-- Card 8
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward'), 8, 'Keep Moving Forward', NULL, NULL, NULL);

-- Component 1 for Card 8
INSERT INTO component_title (content) VALUES ('Keep Moving Forward');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Keep Moving Forward' AND owner_id = (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 8
INSERT INTO component_text (content) VALUES ('When you want to move forward with more purpose and confidence, try to:');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Keep Moving Forward' AND owner_id = (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- ============================================
-- Card 9
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward'), 9, 'Keep Moving Forward', NULL, NULL, NULL);

-- Component 1 for Card 9
INSERT INTO component_title (content) VALUES ('Keep Moving Forward');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Keep Moving Forward' AND owner_id = (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 9
INSERT INTO component_text (content) VALUES ('You do not need complete certainty to move forward.

When you stay connected to what matters, recognise your progress, and keep going, confidence can grow along the way.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Keep Moving Forward' AND owner_id = (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 9
INSERT INTO component_quote (content, author) VALUES ('“Lovely weather so far; I don’t know how long it will last, but I’m not afraid of storms, for I’m learning how to sail my ship.”
— Louisa May Alcott, Little Women', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Keep Moving Forward' AND owner_id = (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 9
INSERT INTO component_last_messages (content) VALUES ('Congratulations — you’ve completed this step.
Keep moving forward with purpose and confidence.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Keep Moving Forward' AND owner_id = (SELECT id FROM module WHERE title = 'Vision, Confidence & Moving Forward') LIMIT 1), 'last message', 4, LAST_INSERT_ID());

-- ============================================
-- End of generated queries
-- ============================================
