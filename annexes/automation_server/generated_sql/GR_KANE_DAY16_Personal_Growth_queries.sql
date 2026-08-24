-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:06.772395
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Course: Believing in Your Growth
-- ============================================

-- Category: Leadership & Personal Growth
-- Check/Create category 'Leadership & Personal Growth'
INSERT IGNORE INTO module_category (title, description, created_at) VALUES ('Leadership & Personal Growth', 'test description', '2026-08-23 19:54:06.769193');

-- Module creation with automatic category lookup
INSERT INTO module (module_category_id, day_number, title, description, target_audience, estimated_duration, created_at) VALUES ((SELECT id FROM module_category WHERE title = 'Leadership & Personal Growth'), 16, 'Believing in Your Growth', 'Understand how self-belief and a growth mindset support your development, and learn to approach challenges with confidence and openness.', 'women learners', 10, '2026-08-23 19:54:06.769204');

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Believing in Your Growth'), 1, 'Believing in Your Growth', NULL, NULL, NULL);

-- Component 1 for Card 1
INSERT INTO component_title (content) VALUES ('Believing in Your Growth');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Believing in Your Growth' AND owner_id = (SELECT id FROM module WHERE title = 'Believing in Your Growth') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 1
INSERT INTO component_video (video_url, video_duration_est, video_alt, video_description) VALUES ('https://drive.google.com/file/d/1XwVPnFq_4KK3vhHchVxyiokTPzCPL4Sm/view?usp=drive_link', NULL, NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Believing in Your Growth' AND owner_id = (SELECT id FROM module WHERE title = 'Believing in Your Growth') LIMIT 1), 'video', 2, LAST_INSERT_ID());

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Believing in Your Growth'), 2, 'How Do You See Yourself?', NULL, NULL, NULL);

-- Component 1 for Card 2
INSERT INTO component_title (content) VALUES ('How Do You See Yourself?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How Do You See Yourself?' AND owner_id = (SELECT id FROM module WHERE title = 'Believing in Your Growth') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 2
INSERT INTO component_text (content) VALUES ('Sometimes we think our abilities are fixed — that we are either “good” or “not good” at something.

This is often called a fixed mindset.

A growth mindset is different. It means believing that you can learn, improve, and develop over time.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How Do You See Yourself?' AND owner_id = (SELECT id FROM module WHERE title = 'Believing in Your Growth') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 2
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1EYhE0H8b82PI0UU4e-qedSBW_4Sb0z_Y/view?usp=drive_link', 'Fixed vs growth mindset comparison', 'A split illustration showing a woman first feeling stuck or discouraged, and then continuing to learn and improve.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How Do You See Yourself?' AND owner_id = (SELECT id FROM module WHERE title = 'Believing in Your Growth') LIMIT 1), 'image', 3, LAST_INSERT_ID());

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Believing in Your Growth'), 3, 'Think About It', NULL, NULL, NULL);

-- Component 1 for Card 3
INSERT INTO component_title (content) VALUES ('Think About It');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Think About It' AND owner_id = (SELECT id FROM module WHERE title = 'Believing in Your Growth') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 3
INSERT INTO component_text (content) VALUES ('Think of a moment when you felt you couldn’t do something or doubted yourself.

What thoughts were going through your mind at that moment?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Think About It' AND owner_id = (SELECT id FROM module WHERE title = 'Believing in Your Growth') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Believing in Your Growth'), 4, 'Growth Takes Time', NULL, NULL, NULL);

-- Component 1 for Card 4
INSERT INTO component_title (content) VALUES ('Growth Takes Time');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Growth Takes Time' AND owner_id = (SELECT id FROM module WHERE title = 'Believing in Your Growth') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 4
INSERT INTO component_text (content) VALUES ('Growth doesn’t happen instantly. It comes from trying, learning, and sometimes making mistakes along the way.

When you see challenges as part of the process, it becomes easier to keep going.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Growth Takes Time' AND owner_id = (SELECT id FROM module WHERE title = 'Believing in Your Growth') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Believing in Your Growth'), 5, 'What Would You Think?', NULL, NULL, NULL);

-- Component 1 for Card 5
INSERT INTO component_title (content) VALUES ('What Would You Think?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What Would You Think?' AND owner_id = (SELECT id FROM module WHERE title = 'Believing in Your Growth') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 5
INSERT INTO component_mcq (question) VALUES ('You try something new and it doesn’t go as planned.

What do you think?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You try something new and it doesn’t go as planned.

What do you think?' ORDER BY id DESC LIMIT 1), 'I’m not good at this.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You try something new and it doesn’t go as planned.

What do you think?' ORDER BY id DESC LIMIT 1), 'This didn’t work — I can try a different way.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You try something new and it doesn’t go as planned.

What do you think?' ORDER BY id DESC LIMIT 1), 'I should probably avoid this next time.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What Would You Think?' AND owner_id = (SELECT id FROM module WHERE title = 'Believing in Your Growth') LIMIT 1), 'mcq', 2, LAST_INSERT_ID());

-- Component 3 for Card 5
INSERT INTO component_last_messages (content) VALUES ('Seeing challenges as opportunities to learn is part of a growth mindset.

Not everything works the first time — trying again is how you improve.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What Would You Think?' AND owner_id = (SELECT id FROM module WHERE title = 'Believing in Your Growth') LIMIT 1), 'last message', 3, LAST_INSERT_ID());

-- ============================================
-- Card 6
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Believing in Your Growth'), 6, 'You Can Learn and Improve', NULL, NULL, NULL);

-- Component 1 for Card 6
INSERT INTO component_title (content) VALUES ('You Can Learn and Improve');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'You Can Learn and Improve' AND owner_id = (SELECT id FROM module WHERE title = 'Believing in Your Growth') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 6
INSERT INTO component_text (content) VALUES ('You don’t have to know everything from the start.

Skills and confidence grow over time — through practice, effort, and experience.

You are not fixed. You can learn, adapt, and improve.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'You Can Learn and Improve' AND owner_id = (SELECT id FROM module WHERE title = 'Believing in Your Growth') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 6
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1qajPXj7wbh5PUeF4Acs0bLeSiw5Y0uiV/view?usp=sharing', NULL, 'A woman engaged in learning or practicing, showing focus and gradual improvement.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'You Can Learn and Improve' AND owner_id = (SELECT id FROM module WHERE title = 'Believing in Your Growth') LIMIT 1), 'image', 3, LAST_INSERT_ID());

-- ============================================
-- Card 7
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Believing in Your Growth'), 7, 'Try a Different Thought', NULL, NULL, NULL);

-- Component 1 for Card 7
INSERT INTO component_title (content) VALUES ('Try a Different Thought');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Try a Different Thought' AND owner_id = (SELECT id FROM module WHERE title = 'Believing in Your Growth') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 7
INSERT INTO component_text (content) VALUES ('Think back to the moment you reflected on earlier.

How could you rephrase your thoughts in a more supportive way?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Try a Different Thought' AND owner_id = (SELECT id FROM module WHERE title = 'Believing in Your Growth') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 7
INSERT INTO component_open_questions (question) VALUES ('Rewrite one of your thoughts to reflect a growth mindset.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Try a Different Thought' AND owner_id = (SELECT id FROM module WHERE title = 'Believing in Your Growth') LIMIT 1), 'open question', 3, LAST_INSERT_ID());

-- ============================================
-- Card 8
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Believing in Your Growth'), 8, 'Take It Forward', NULL, NULL, NULL);

-- Component 1 for Card 8
INSERT INTO component_title (content) VALUES ('Take It Forward');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Take It Forward' AND owner_id = (SELECT id FROM module WHERE title = 'Believing in Your Growth') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 8
INSERT INTO component_text (content) VALUES ('The next time you face a challenge, try to notice your thoughts.

Choose a more supportive and growth-oriented way to respond.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Take It Forward' AND owner_id = (SELECT id FROM module WHERE title = 'Believing in Your Growth') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 8
INSERT INTO component_open_questions (question) VALUES ('What is one thought you will try to use the next time you face a challenge?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Take It Forward' AND owner_id = (SELECT id FROM module WHERE title = 'Believing in Your Growth') LIMIT 1), 'open question', 3, LAST_INSERT_ID());

-- ============================================
-- Card 9
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Believing in Your Growth'), 9, 'You Are Growing', NULL, NULL, NULL);

-- Component 1 for Card 9
INSERT INTO component_title (content) VALUES ('You Are Growing');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'You Are Growing' AND owner_id = (SELECT id FROM module WHERE title = 'Believing in Your Growth') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 9
INSERT INTO component_text (content) VALUES ('Growth doesn’t mean having all the answers. 

It means being open to learning, trying, and moving forward — step by step.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'You Are Growing' AND owner_id = (SELECT id FROM module WHERE title = 'Believing in Your Growth') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 9
INSERT INTO component_last_messages (content) VALUES ('Congratulations — you’ve completed this step.
Growth happens one step at a time.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'You Are Growing' AND owner_id = (SELECT id FROM module WHERE title = 'Believing in Your Growth') LIMIT 1), 'last message', 3, LAST_INSERT_ID());

-- ============================================
-- End of generated queries
-- ============================================
