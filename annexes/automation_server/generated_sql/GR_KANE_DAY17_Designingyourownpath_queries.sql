-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:06.816811
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Course: Designing Your Growth Path
-- ============================================

-- Category: Leadership & Personal Growth
-- Check/Create category 'Leadership & Personal Growth'
INSERT IGNORE INTO module_category (title, description, created_at) VALUES ('Leadership & Personal Growth', 'test description', '2026-08-23 19:54:06.813744');

-- Module creation with automatic category lookup
INSERT INTO module (module_category_id, day_number, title, description, target_audience, estimated_duration, created_at) VALUES ((SELECT id FROM module_category WHERE title = 'Leadership & Personal Growth'), 17, 'Designing Your Growth Path', 'Understand how clear goals and small, consistent actions can support your personal growth and help you move forward with intention.', 'women learners', 10, '2026-08-23 19:54:06.813755');

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Designing Your Growth Path'), 1, 'Designing Your Growth Path', NULL, NULL, NULL);

-- Component 1 for Card 1
INSERT INTO component_title (content) VALUES ('Designing Your Growth Path');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Designing Your Growth Path' AND owner_id = (SELECT id FROM module WHERE title = 'Designing Your Growth Path') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 1
INSERT INTO component_video (video_url, video_duration_est, video_alt, video_description) VALUES ('https://drive.google.com/file/d/1GYJQ2D0opSwdrZSl-9AZVK9i9PHZEfkB/view?usp=drive_link', NULL, NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Designing Your Growth Path' AND owner_id = (SELECT id FROM module WHERE title = 'Designing Your Growth Path') LIMIT 1), 'video', 2, LAST_INSERT_ID());

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Designing Your Growth Path'), 2, 'Why Goals Matter', NULL, NULL, NULL);

-- Component 1 for Card 2
INSERT INTO component_title (content) VALUES ('Why Goals Matter');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Why Goals Matter' AND owner_id = (SELECT id FROM module WHERE title = 'Designing Your Growth Path') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 2
INSERT INTO component_text (content) VALUES ('Goals give direction to your growth.

They help you focus on what matters, make clearer choices, and move forward with more intention.

Without direction, it is easy to stay busy without making real progress.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Why Goals Matter' AND owner_id = (SELECT id FROM module WHERE title = 'Designing Your Growth Path') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Designing Your Growth Path'), 3, 'What Do You Want to Grow?', NULL, NULL, NULL);

-- Component 1 for Card 3
INSERT INTO component_title (content) VALUES ('What Do You Want to Grow?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What Do You Want to Grow?' AND owner_id = (SELECT id FROM module WHERE title = 'Designing Your Growth Path') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 3
INSERT INTO component_text (content) VALUES ('Take a moment to think about one area of your life where you would like to grow.

It could be something personal, professional, or related to how you lead.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What Do You Want to Grow?' AND owner_id = (SELECT id FROM module WHERE title = 'Designing Your Growth Path') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 3
INSERT INTO component_open_questions (question) VALUES ('What is one area you would like to improve or develop right now?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What Do You Want to Grow?' AND owner_id = (SELECT id FROM module WHERE title = 'Designing Your Growth Path') LIMIT 1), 'open question', 3, LAST_INSERT_ID());

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Designing Your Growth Path'), 4, 'Start Smaller', NULL, NULL, NULL);

-- Component 1 for Card 4
INSERT INTO component_title (content) VALUES ('Start Smaller');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Start Smaller' AND owner_id = (SELECT id FROM module WHERE title = 'Designing Your Growth Path') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 4
INSERT INTO component_text (content) VALUES ('A big goal can feel exciting — but also overwhelming.

Breaking it into smaller steps makes it easier to begin, stay consistent, and notice progress along the way.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Start Smaller' AND owner_id = (SELECT id FROM module WHERE title = 'Designing Your Growth Path') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 4
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1jV8s8Pg5wpmkY3n-JjtOYMjdrU281_HL/view?usp=sharing', 'Woman focusing on the first step', 'A woman facing a larger path but concentrating on the first step, symbolising manageable progress and realistic growth.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Start Smaller' AND owner_id = (SELECT id FROM module WHERE title = 'Designing Your Growth Path') LIMIT 1), 'image', 3, LAST_INSERT_ID());

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Designing Your Growth Path'), 5, 'What Is the Best Next Step?', NULL, NULL, NULL);

-- Component 1 for Card 5
INSERT INTO component_title (content) VALUES ('What Is the Best Next Step?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What Is the Best Next Step?' AND owner_id = (SELECT id FROM module WHERE title = 'Designing Your Growth Path') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 5
INSERT INTO component_mcq (question) VALUES ('You want to become more confident when speaking in front of others.

What is the best way to begin?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You want to become more confident when speaking in front of others.

What is the best way to begin?' ORDER BY id DESC LIMIT 1), 'Wait until you feel completely ready');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You want to become more confident when speaking in front of others.

What is the best way to begin?' ORDER BY id DESC LIMIT 1), 'Set one small goal, like speaking once in your next meeting or group discussion');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You want to become more confident when speaking in front of others.

What is the best way to begin?' ORDER BY id DESC LIMIT 1), 'Try to change everything at once');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What Is the Best Next Step?' AND owner_id = (SELECT id FROM module WHERE title = 'Designing Your Growth Path') LIMIT 1), 'mcq', 2, LAST_INSERT_ID());

-- Component 3 for Card 5
INSERT INTO component_last_messages (content) VALUES ('A small, clear step makes growth easier to start and easier to sustain.

You do not need to do everything at once. Progress often begins with one realistic action.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What Is the Best Next Step?' AND owner_id = (SELECT id FROM module WHERE title = 'Designing Your Growth Path') LIMIT 1), 'last message', 3, LAST_INSERT_ID());

-- ============================================
-- Card 6
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Designing Your Growth Path'), 6, 'Small Habits, Real Progress', NULL, NULL, NULL);

-- Component 1 for Card 6
INSERT INTO component_title (content) VALUES ('Small Habits, Real Progress');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Small Habits, Real Progress' AND owner_id = (SELECT id FROM module WHERE title = 'Designing Your Growth Path') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 6
INSERT INTO component_text (content) VALUES ('Growth is not only about setting goals. It also depends on what you do regularly.

Small habits can help you stay connected to your goals and keep moving forward, even on busy days.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Small Habits, Real Progress' AND owner_id = (SELECT id FROM module WHERE title = 'Designing Your Growth Path') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- ============================================
-- Card 7
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Designing Your Growth Path'), 7, 'What Could Work for You?', NULL, NULL, NULL);

-- Component 1 for Card 7
INSERT INTO component_title (content) VALUES ('What Could Work for You?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What Could Work for You?' AND owner_id = (SELECT id FROM module WHERE title = 'Designing Your Growth Path') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 7
INSERT INTO component_text (content) VALUES ('Think about the area you want to grow in.

What is one small step or habit that could realistically fit into your life right now?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What Could Work for You?' AND owner_id = (SELECT id FROM module WHERE title = 'Designing Your Growth Path') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 7
INSERT INTO component_open_questions (question) VALUES ('Think about the area you want to grow in. What is one small step or habit that feels realistic for you right now?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What Could Work for You?' AND owner_id = (SELECT id FROM module WHERE title = 'Designing Your Growth Path') LIMIT 1), 'open question', 3, LAST_INSERT_ID());

-- ============================================
-- Card 8
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Designing Your Growth Path'), 8, 'Choose Your Next Step', NULL, NULL, NULL);

-- Component 1 for Card 8
INSERT INTO component_title (content) VALUES ('Choose Your Next Step');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Choose Your Next Step' AND owner_id = (SELECT id FROM module WHERE title = 'Designing Your Growth Path') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 8
INSERT INTO component_text (content) VALUES ('Now choose one small action you want to begin with.

Keep it simple and realistic — something that feels possible for you right now.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Choose Your Next Step' AND owner_id = (SELECT id FROM module WHERE title = 'Designing Your Growth Path') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 8
INSERT INTO component_open_questions (question) VALUES ('What is one small step you will start with?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Choose Your Next Step' AND owner_id = (SELECT id FROM module WHERE title = 'Designing Your Growth Path') LIMIT 1), 'open question', 3, LAST_INSERT_ID());

-- ============================================
-- Card 9
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Designing Your Growth Path'), 9, 'One Step at a Time', NULL, NULL, NULL);

-- Component 1 for Card 9
INSERT INTO component_title (content) VALUES ('One Step at a Time');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'One Step at a Time' AND owner_id = (SELECT id FROM module WHERE title = 'Designing Your Growth Path') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 9
INSERT INTO component_text (content) VALUES ('Growth does not require a perfect plan.

It begins when you choose a direction, take one small step, and keep going.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'One Step at a Time' AND owner_id = (SELECT id FROM module WHERE title = 'Designing Your Growth Path') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 9
INSERT INTO component_last_messages (content) VALUES ('Congratulations — you’ve completed this step.
Small, consistent actions can lead to meaningful growth.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'One Step at a Time' AND owner_id = (SELECT id FROM module WHERE title = 'Designing Your Growth Path') LIMIT 1), 'last message', 3, LAST_INSERT_ID());

-- ============================================
-- End of generated queries
-- ============================================
