-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:06.619814
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Course: Proactive Leadership in Daily Life
-- ============================================

-- Category: Leadership & Personal Growth
-- Check/Create category 'Leadership & Personal Growth'
INSERT IGNORE INTO module_category (title, description, created_at) VALUES ('Leadership & Personal Growth', 'test description', '2026-08-23 19:54:06.617006');

-- Module creation with automatic category lookup
INSERT INTO module (module_category_id, day_number, title, description, target_audience, estimated_duration, created_at) VALUES ((SELECT id FROM module_category WHERE title = 'Leadership & Personal Growth'), 15, 'Proactive Leadership in Daily Life', 'Understand the difference between reactive and proactive leadership and learn how to take initiative in everyday situations.', 'women learners', 10, '2026-08-23 19:54:06.617015');

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life'), 1, 'Proactive Leadership in Daily Life', NULL, NULL, NULL);

-- Component 1 for Card 1
INSERT INTO component_title (content) VALUES ('Proactive Leadership in Daily Life');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Proactive Leadership in Daily Life' AND owner_id = (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 1
INSERT INTO component_text (content) VALUES ('Leadership shows in how you act every day. Instead of waiting and reacting, you can choose to take initiative and shape what happens around you.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Proactive Leadership in Daily Life' AND owner_id = (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 1
INSERT INTO component_video (video_url, video_duration_est, video_alt, video_description) VALUES ('https://drive.google.com/file/d/1VD_KltiBvXzBNT8K0H7uu8QFLtfinlKu/view?usp=drive_link', NULL, NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Proactive Leadership in Daily Life' AND owner_id = (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life') LIMIT 1), 'video', 3, LAST_INSERT_ID());

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life'), 2, 'Reactive or Proactive?', NULL, NULL, NULL);

-- Component 1 for Card 2
INSERT INTO component_title (content) VALUES ('Reactive or Proactive?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Reactive or Proactive?' AND owner_id = (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 2
INSERT INTO component_text (content) VALUES ('In daily life, we often respond to what happens around us. This is called being reactive — waiting, responding, or following what others do.

Being proactive is different. It means taking initiative, making choices, and acting before being asked.

Both are natural. But leadership grows when you choose to be proactive.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Reactive or Proactive?' AND owner_id = (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life'), 3, 'Think About It', NULL, NULL, NULL);

-- Component 1 for Card 3
INSERT INTO component_title (content) VALUES ('Think About It');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Think About It' AND owner_id = (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 3
INSERT INTO component_text (content) VALUES ('Think about a recent situation where you waited instead of acting.

What stopped you?
Was it uncertainty, hesitation, or expecting someone else to take the lead?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Think About It' AND owner_id = (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 3
INSERT INTO component_last_messages (content) VALUES ('Take a moment to reflect upon this before moving forward.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Think About It' AND owner_id = (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life') LIMIT 1), 'last message', 3, LAST_INSERT_ID());

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life'), 4, 'Spot the Difference', NULL, NULL, NULL);

-- Component 1 for Card 4
INSERT INTO component_title (content) VALUES ('Spot the Difference');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Spot the Difference' AND owner_id = (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 4
INSERT INTO component_text (content) VALUES ('Which one feels more familiar to you?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Spot the Difference' AND owner_id = (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 4
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/drive/folders/1eSaYQlUEzckfailf-tI9rt3kOVNV-Ftp?usp=drive_link', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Spot the Difference' AND owner_id = (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life') LIMIT 1), 'image', 3, LAST_INSERT_ID());

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life'), 5, 'What Would You Do?', NULL, NULL, NULL);

-- Component 1 for Card 5
INSERT INTO component_title (content) VALUES ('What Would You Do?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What Would You Do?' AND owner_id = (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 5
INSERT INTO component_mcq (question) VALUES ('You are in a group discussion. Everyone is quiet, and no one is taking the lead.

What do you do?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You are in a group discussion. Everyone is quiet, and no one is taking the lead.

What do you do?' ORDER BY id DESC LIMIT 1), 'Wait for someone else to speak first');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You are in a group discussion. Everyone is quiet, and no one is taking the lead.

What do you do?' ORDER BY id DESC LIMIT 1), 'Stay silent and follow what others decide');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You are in a group discussion. Everyone is quiet, and no one is taking the lead.

What do you do?' ORDER BY id DESC LIMIT 1), 'Share an idea or ask a simple question to start the discussion');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What Would You Do?' AND owner_id = (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life') LIMIT 1), 'mcq', 2, LAST_INSERT_ID());

-- Component 3 for Card 5
INSERT INTO component_last_messages (content) VALUES ('Taking initiative, even in small ways, is a proactive leadership behavior.

Waiting is natural — but simple actions like sharing an idea or asking a question can help move things forward — and position you as someone who leads through action.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What Would You Do?' AND owner_id = (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life') LIMIT 1), 'last message', 3, LAST_INSERT_ID());

-- ============================================
-- Card 6
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life'), 6, 'You Can Take Initiative', NULL, NULL, NULL);

-- Component 1 for Card 6
INSERT INTO component_title (content) VALUES ('You Can Take Initiative');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'You Can Take Initiative' AND owner_id = (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 6

-- List item 2: You don’t always need permission to take initiativ...
INSERT INTO component_list (content) VALUES ('You don’t always need permission to take initiative.

Proactive leadership can be simple. For example, you can:');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'You Can Take Initiative' AND owner_id = (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life') LIMIT 1), 'list', 2, LAST_INSERT_ID());

-- List item 3: Ask a question...
INSERT INTO component_list (content) VALUES ('Ask a question');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'You Can Take Initiative' AND owner_id = (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life') LIMIT 1), 'list', 3, LAST_INSERT_ID());

-- List item 4: Share an idea...
INSERT INTO component_list (content) VALUES ('Share an idea');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'You Can Take Initiative' AND owner_id = (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life') LIMIT 1), 'list', 4, LAST_INSERT_ID());

-- List item 5: Offer help...
INSERT INTO component_list (content) VALUES ('Offer help');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'You Can Take Initiative' AND owner_id = (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life') LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: Start a conversation...
INSERT INTO component_list (content) VALUES ('Start a conversation');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'You Can Take Initiative' AND owner_id = (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life') LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- List item 7: Suggest a solution...
INSERT INTO component_list (content) VALUES ('Suggest a solution');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'You Can Take Initiative' AND owner_id = (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life') LIMIT 1), 'list', 7, LAST_INSERT_ID());

-- Component 8 for Card 6
INSERT INTO component_last_messages (content) VALUES ('These small actions can make a real difference.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'You Can Take Initiative' AND owner_id = (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life') LIMIT 1), 'last message', 8, LAST_INSERT_ID());

-- ============================================
-- Card 7
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life'), 7, 'Your Turn', NULL, NULL, NULL);

-- Component 1 for Card 7
INSERT INTO component_title (content) VALUES ('Your Turn');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your Turn' AND owner_id = (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 7
INSERT INTO component_text (content) VALUES ('Think of a situation where you usually stay quiet or wait.

What is one small action you could take next time?

You might find it helpful to write it down — this can make it easier to remember and follow through.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your Turn' AND owner_id = (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- ============================================
-- Card 8
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life'), 8, 'Take a Small Step', NULL, NULL, NULL);

-- Component 1 for Card 8
INSERT INTO component_title (content) VALUES ('Take a Small Step');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Take a Small Step' AND owner_id = (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 8
INSERT INTO component_text (content) VALUES ('Choose one small action you will take the next time you are in a similar situation.

It doesn’t have to be big — even a simple step can make a difference.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Take a Small Step' AND owner_id = (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 8
INSERT INTO component_open_questions (question) VALUES ('What is one small step you will take next time?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Take a Small Step' AND owner_id = (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life') LIMIT 1), 'open question', 3, LAST_INSERT_ID());

-- ============================================
-- Card 9
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life'), 9, 'Leadership in Action', NULL, NULL, NULL);

-- Component 1 for Card 9
INSERT INTO component_title (content) VALUES ('Leadership in Action');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Leadership in Action' AND owner_id = (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 9
INSERT INTO component_text (content) VALUES ('Leadership is not only about big decisions — it’s also about the small actions you take every day.

Each time you choose to take initiative, you are practicing leadership.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Leadership in Action' AND owner_id = (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 9
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1pyiuqKF8C2469DUG5vL6zHFOaTK1WDAI/view?usp=drive_link (sample… I think we said that VisionTree would create the images, no?)', NULL, 'A woman taking a small step forward (literally or symbolically), slightly ahead of a group or moving confidently.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Leadership in Action' AND owner_id = (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life') LIMIT 1), 'image', 3, LAST_INSERT_ID());

-- Component 4 for Card 9
INSERT INTO component_last_messages (content) VALUES ('Congratulations — you’ve completed this step.

Every small step you take is part of your leadership journey.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Leadership in Action' AND owner_id = (SELECT id FROM module WHERE title = 'Proactive Leadership in Daily Life') LIMIT 1), 'last message', 4, LAST_INSERT_ID());

-- ============================================
-- End of generated queries
-- ============================================
