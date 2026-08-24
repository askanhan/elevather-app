-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:06.671286
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Course: Presentation
-- ============================================

-- Category: Leadership & Personal Growth
-- Check/Create category 'Leadership & Personal Growth'
INSERT IGNORE INTO module_category (title, description, created_at) VALUES ('Leadership & Personal Growth', 'test description', '2026-08-23 19:54:06.668421');

-- Module creation with automatic category lookup
INSERT INTO module (module_category_id, day_number, title, description, target_audience, estimated_duration, created_at) VALUES ((SELECT id FROM module_category WHERE title = 'Leadership & Personal Growth'), 14, 'Presentation', 'Understand your leadership identity and learn how to lead authentically based on your strengths and values.', 'women learners', 10, '2026-08-23 19:54:06.668431');

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Presentation'), 1, 'Knowing Yourself as a Leader', NULL, NULL, NULL);

-- Component 1 for Card 1
INSERT INTO component_title (content) VALUES ('Knowing Yourself as a Leader');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Knowing Yourself as a Leader' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 1
INSERT INTO component_text (content) VALUES ('Leadership starts with you. Before leading others, it’s important to understand who you are, what you value, and how you naturally show up in the world.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Knowing Yourself as a Leader' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 1
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1gYdd0bi0mO4HBypLxEQnppY5wTxLm3uM/view?usp=drive_link', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Knowing Yourself as a Leader' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'image', 3, LAST_INSERT_ID());

-- Component 4 for Card 1
INSERT INTO component_video (video_url, video_duration_est, video_alt, video_description) VALUES ('https://drive.google.com/file/d/1mc0TDyWi04zZxuIhRPorj1C9sEWoEAQC/view?usp=drive_link', NULL, NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Knowing Yourself as a Leader' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'video', 4, LAST_INSERT_ID());

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Presentation'), 2, 'Leadership Is Not a Title', NULL, NULL, NULL);

-- Component 1 for Card 2
INSERT INTO component_title (content) VALUES ('Leadership Is Not a Title');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Leadership Is Not a Title' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 2
INSERT INTO component_text (content) VALUES ('Leadership is not about a position or a job title. It’s about how you act, make decisions, and support others — in everyday situations.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Leadership Is Not a Title' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 2
INSERT INTO component_quote (content, author) VALUES ('Leadership is not about a title or a designation. It’s about impact, influence, and inspiration.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Leadership Is Not a Title' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 2
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1sjTT_LV8sjzaW5UFiFSWu4j2YHd5SPv0/view?usp=drive_link', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Leadership Is Not a Title' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'image', 4, LAST_INSERT_ID());

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Presentation'), 3, 'You Are Already Leading', 'Where in your daily life are you already showing leadership?', NULL, NULL);

-- Component 1 for Card 3
INSERT INTO component_title (content) VALUES ('You Are Already Leading');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'You Are Already Leading' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 3
INSERT INTO component_text (content) VALUES ('You don’t need permission to be a leader. Every time you support someone, take initiative, or make a decision, you are already leading — even in small, everyday moments.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'You Are Already Leading' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 3
INSERT INTO component_subtitle (content) VALUES ('Where in your daily life are you already showing leadership?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'You Are Already Leading' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'subtitle', 3, LAST_INSERT_ID());

-- Component 4 for Card 3
INSERT INTO component_open_questions (question) VALUES ('Think of one recent moment where you supported someone, made a decision, or took initiative. What did you do?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'You Are Already Leading' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'open question', 4, LAST_INSERT_ID());

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Presentation'), 4, 'Your Leadership Is Personal', NULL, NULL, NULL);

-- Component 1 for Card 4
INSERT INTO component_title (content) VALUES ('Your Leadership Is Personal');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your Leadership Is Personal' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 4
INSERT INTO component_text (content) VALUES ('There is no single “right” way to lead. Your leadership is shaped by who you are — your values, your experiences, and your personality.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your Leadership Is Personal' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 4
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1nlKBZXtfrkNQ15asBYQFD6ZPq82mHPUA/view?usp=drive_link', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your Leadership Is Personal' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'image', 3, LAST_INSERT_ID());

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Presentation'), 5, 'How Would You Respond?', 'Think: Which option feels most natural to you — and why?', NULL, NULL);

-- Component 1 for Card 5
INSERT INTO component_title (content) VALUES ('How Would You Respond?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How Would You Respond?' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 5
INSERT INTO component_text (content) VALUES ('Leadership often shows up in small, everyday situations. There isn’t always one “right” answer — but your response shapes how others feel and act.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How Would You Respond?' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 5
INSERT INTO component_subtitle (content) VALUES ('Think: Which option feels most natural to you — and why?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How Would You Respond?' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'subtitle', 3, LAST_INSERT_ID());

-- Component 4 for Card 5
INSERT INTO component_mcq (question) VALUES ('A colleague seems discouraged and less engaged than usual. What would you do?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'A colleague seems discouraged and less engaged than usual. What would you do?' ORDER BY id DESC LIMIT 1), 'Focus on the task and remind them what needs to be done');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'A colleague seems discouraged and less engaged than usual. What would you do?' ORDER BY id DESC LIMIT 1), 'Take a moment to ask how they are feeling and listen');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'A colleague seems discouraged and less engaged than usual. What would you do?' ORDER BY id DESC LIMIT 1), 'Encourage them and remind them of their strengths');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How Would You Respond?' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'mcq', 4, LAST_INSERT_ID());

-- ============================================
-- Card 6
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Presentation'), 6, 'Leading in Your Own Way', NULL, NULL, NULL);

-- Component 1 for Card 6
INSERT INTO component_title (content) VALUES ('Leading in Your Own Way');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Leading in Your Own Way' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 6
INSERT INTO component_text (content) VALUES ('You don’t need to copy someone else’s style to be a good leader. The most effective leaders are those who lead in a way that feels natural and true to who they are.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Leading in Your Own Way' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 6
INSERT INTO component_quote (content, author) VALUES ('You alone are enough. You have nothing to prove to anybody.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Leading in Your Own Way' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 6
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1VqY4o-WeYtWpyvdK5MH-BGieDeEBFbAb/view?usp=drive_link', NULL, 'A woman leader being herself amongst a group of people. Demonstrating authenticity and self-awareness');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Leading in Your Own Way' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'image', 4, LAST_INSERT_ID());

-- ============================================
-- Card 7
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Presentation'), 7, 'Flexibility Is Strength', 'When was the last time you adjusted your approach to better support someone?', NULL, NULL);

-- Component 1 for Card 7
INSERT INTO component_title (content) VALUES ('Flexibility Is Strength');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Flexibility Is Strength' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 7
INSERT INTO component_text (content) VALUES ('Being yourself as a leader doesn’t mean always acting the same way. Strong leaders stay true to their values, but adapt their approach depending on the situation and the people around them.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Flexibility Is Strength' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 7
INSERT INTO component_subtitle (content) VALUES ('When was the last time you adjusted your approach to better support someone?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Flexibility Is Strength' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'subtitle', 3, LAST_INSERT_ID());

-- Component 4 for Card 7
INSERT INTO component_open_questions (question) VALUES ('Think of a recent situation. How did you respond.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Flexibility Is Strength' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'open question', 4, LAST_INSERT_ID());

-- Component 5 for Card 7
INSERT INTO component_open_questions (question) VALUES ('What could you try differently next time?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Flexibility Is Strength' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'open question', 5, LAST_INSERT_ID());

-- ============================================
-- Card 8
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Presentation'), 8, 'Your Leadership Strength', NULL, NULL, NULL);

-- Component 1 for Card 8
INSERT INTO component_title (content) VALUES ('Your Leadership Strength');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your Leadership Strength' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 8
INSERT INTO component_text (content) VALUES ('You already have strengths that support your leadership. The next step is to recognise them and use them more intentionally in your daily life.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your Leadership Strength' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 8
INSERT INTO component_open_questions (question) VALUES ('What is one leadership strength you want to use more this week?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your Leadership Strength' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'open question', 3, LAST_INSERT_ID());

-- ============================================
-- Card 9
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Presentation'), 9, 'You Are Already on the Path', NULL, NULL, NULL);

-- Component 1 for Card 9
INSERT INTO component_title (content) VALUES ('You Are Already on the Path');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'You Are Already on the Path' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 9
INSERT INTO component_text (content) VALUES ('Leadership doesn’t happen overnight. It grows through small steps, self-awareness, and everyday actions — and you’ve already started that journey.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'You Are Already on the Path' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 9
INSERT INTO component_last_messages (content) VALUES ('Well done. You’ve taken your first step — keep going.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'You Are Already on the Path' AND owner_id = (SELECT id FROM module WHERE title = 'Presentation') LIMIT 1), 'last message', 3, LAST_INSERT_ID());

-- ============================================
-- End of generated queries
-- ============================================
