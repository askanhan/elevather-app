-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:05.028685
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Course: nan
-- ============================================

-- Category: this field must be completed ! e.g  :  I Dare, Leadership, ...
-- Check/Create category 'this field must be completed ! e.g  :  I Dare, Leadership, ...'
INSERT IGNORE INTO module_category (title, description, created_at) VALUES ('this field must be completed ! e.g  :  I Dare, Leadership, ...', 'test description', '2026-08-23 19:54:05.025155');

-- Module creation with automatic category lookup
INSERT INTO module (module_category_id, day_number, title, description, target_audience, estimated_duration, created_at) VALUES ((SELECT id FROM module_category WHERE title = 'this field must be completed ! e.g  :  I Dare, Leadership, ...'), 1, nan, nan, 'working mom, first-time managers, women, ... ', 0, '2026-08-23 19:54:05.025170');

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 1, 'Purpose of the speech - Let’s Find It', NULL, NULL, NULL);

-- Component 1 for Card 1
INSERT INTO component_title (content) VALUES ('Purpose of the speech - Let’s Find It');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Purpose of the speech - Let’s Find It' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 1
INSERT INTO component_text (content) VALUES ('This lesson is intended to help you prepare for speeches that are in line with your intentions.Think about why you really want to perform.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Purpose of the speech - Let’s Find It' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 1
INSERT INTO component_video (video_url, video_duration_est, video_alt, video_description) VALUES ('https://drive.google.com/file/d/1E59A4bZYEkUtvRFM-4ISjDOZ0XzHyzKy/view?usp=drive_link', 'must be a number', 'short description of what the image is', 'detailed explanation of what the image shows');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Purpose of the speech - Let’s Find It' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'video', 3, LAST_INSERT_ID());

-- Component 4 for Card 1
INSERT INTO component_open_questions (question) VALUES ('Do you really understand and feel the purpose of your speech? What is it?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Purpose of the speech - Let’s Find It' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 4, LAST_INSERT_ID());

-- Component 5 for Card 1

-- List item 5: Think it over carefully :-)...
INSERT INTO component_list (content) VALUES ('Think it over carefully :-)');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Purpose of the speech - Let’s Find It' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: 1. Write down what your most important intention i...
INSERT INTO component_list (content) VALUES ('1. Write down what your most important intention is in connection with the speech?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Purpose of the speech - Let’s Find It' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- List item 7: 2. Imagine one thing that should stay in the minds...
INSERT INTO component_list (content) VALUES ('2. Imagine one thing that should stay in the minds and hearts of your listeners?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Purpose of the speech - Let’s Find It' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 7, LAST_INSERT_ID());

-- Component 8 for Card 1
INSERT INTO component_last_messages (content) VALUES ('The first step is behind you, it''s time for the next one ;-)');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Purpose of the speech - Let’s Find It' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 8, LAST_INSERT_ID());

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 2, 'How will I achieve the purpose of my speech?', NULL, NULL, NULL);

-- Component 1 for Card 2
INSERT INTO component_title (content) VALUES ('How will I achieve the purpose of my speech?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How will I achieve the purpose of my speech?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 2
INSERT INTO component_text (content) VALUES ('When you clearly understand the purpose of your speech, you can plan what to say and how to say it to capture its essence. A speech plan is a carefully considered sequence that allows you to clearly convey your intentions.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How will I achieve the purpose of my speech?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 2
INSERT INTO component_open_questions (question) VALUES ('What should I say and present to achieve my speech goals? In what order should I present my ideas and topics?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How will I achieve the purpose of my speech?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 3, LAST_INSERT_ID());

-- Component 4 for Card 2

-- List item 4: Make sure you have thought it through....
INSERT INTO component_list (content) VALUES ('Make sure you have thought it through.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How will I achieve the purpose of my speech?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 4, LAST_INSERT_ID());

-- List item 5: 1. Purpose of the presentation...
INSERT INTO component_list (content) VALUES ('1. Purpose of the presentation');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How will I achieve the purpose of my speech?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: 2. Agenda - introduction, main points, summary, an...
INSERT INTO component_list (content) VALUES ('2. Agenda - introduction, main points, summary, and conclusion.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How will I achieve the purpose of my speech?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- List item 7: 3. Training methods and aids I will use....
INSERT INTO component_list (content) VALUES ('3. Training methods and aids I will use.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How will I achieve the purpose of my speech?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 7, LAST_INSERT_ID());

-- Component 8 for Card 2
INSERT INTO component_last_messages (content) VALUES ('Well done! You perform naturally and spontaneously if you are well prepared! :-)');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How will I achieve the purpose of my speech?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 8, LAST_INSERT_ID());

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 3, 'Content breakdown over time', NULL, NULL, NULL);

-- Component 1 for Card 3
INSERT INTO component_title (content) VALUES ('Content breakdown over time');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Content breakdown over time' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 3
INSERT INTO component_text (content) VALUES ('Know exactly how much time you have for your presentation. It''s important to stay on time during your presentation. Plan your presentation so you don''t have to extend it. If necessary, practice it in advance and check your timing.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Content breakdown over time' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 3
INSERT INTO component_open_questions (question) VALUES ('What do I absolutely need to fit into my scheduled time? Are there any topics I can skip?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Content breakdown over time' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 3, LAST_INSERT_ID());

-- Component 4 for Card 3
INSERT INTO component_last_messages (content) VALUES ('Good time planning shows your professionalism. Fingers crossed!');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Content breakdown over time' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 4, LAST_INSERT_ID());

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 4, 'Methods and tools', NULL, NULL, NULL);

-- Component 1 for Card 4
INSERT INTO component_title (content) VALUES ('Methods and tools');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Methods and tools' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 4
INSERT INTO component_text (content) VALUES ('When planning your presentation, think about your delivery methods and what might reinforce or illustrate your message. The idea is to make your audience feel you''re reaching them. Examples and drawing on shared experiences work well.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Methods and tools' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 4
INSERT INTO component_quote (content, author) VALUES ('„Sometimes a picture says more than words”', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Methods and tools' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 4
INSERT INTO component_open_questions (question) VALUES ('Do you have good real-life examples, short videos, or strong arguments? Write them down.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Methods and tools' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 4, LAST_INSERT_ID());

-- Component 5 for Card 4
INSERT INTO component_last_messages (content) VALUES ('People remember better what moved them emotionally! Go for the next step.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Methods and tools' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 5, LAST_INSERT_ID());

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 5, 'The beginning of your performence', NULL, NULL, NULL);

-- Component 1 for Card 5
INSERT INTO component_title (content) VALUES ('The beginning of your performence');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The beginning of your performence' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 5
INSERT INTO component_text (content) VALUES ('People remember best what comes first and what comes last. So, consider the beginning of your speech carefully.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The beginning of your performence' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 5
INSERT INTO component_open_questions (question) VALUES ('Think about how you''ll begin your speech to grab attention. How will you intrigue your audience?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The beginning of your performence' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 3, LAST_INSERT_ID());

-- Component 4 for Card 5

-- List item 4: Think about how you will start...
INSERT INTO component_list (content) VALUES ('Think about how you will start');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The beginning of your performence' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 4, LAST_INSERT_ID());

-- List item 5: 1. You can ask a rhetorical question...
INSERT INTO component_list (content) VALUES ('1. You can ask a rhetorical question');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The beginning of your performence' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: 2. You can start with an intriguing story...
INSERT INTO component_list (content) VALUES ('2. You can start with an intriguing story');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The beginning of your performence' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- List item 7: 3. You can use a metaphor or symbolic image...
INSERT INTO component_list (content) VALUES ('3. You can use a metaphor or symbolic image');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The beginning of your performence' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 7, LAST_INSERT_ID());

-- Component 8 for Card 5
INSERT INTO component_last_messages (content) VALUES ('You only make a first impression once ;-)');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The beginning of your performence' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 8, LAST_INSERT_ID());

-- ============================================
-- Card 6
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 6, 'The end of your speach', NULL, NULL, NULL);

-- Component 1 for Card 6
INSERT INTO component_title (content) VALUES ('The end of your speach');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The end of your speach' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 6
INSERT INTO component_text (content) VALUES ('The ending will definitely be memorable. Think about what you want to emphasize at the end.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The end of your speach' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 6
INSERT INTO component_open_questions (question) VALUES ('What do you want people to remember from your presentation? What emotion do you want them to leave with?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The end of your speach' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 3, LAST_INSERT_ID());

-- Component 4 for Card 6
INSERT INTO component_last_messages (content) VALUES ('It is worth ending your speech elegantly! Go for it!');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The end of your speach' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 4, LAST_INSERT_ID());

-- ============================================
-- Card 7
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 7, 'Appreciate the support of others', NULL, NULL, NULL);

-- Component 1 for Card 7
INSERT INTO component_title (content) VALUES ('Appreciate the support of others');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Appreciate the support of others' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 7
INSERT INTO component_text (content) VALUES ('It''s worth discussing your presentation and getting feedback from well-wishers.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Appreciate the support of others' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 7
INSERT INTO component_open_questions (question) VALUES ('Who could support you before your presentation? When can you meet and talk?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Appreciate the support of others' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 3, LAST_INSERT_ID());

-- Component 4 for Card 7

-- List item 4: Take support seriously....
INSERT INTO component_list (content) VALUES ('Take support seriously.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Appreciate the support of others' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 4, LAST_INSERT_ID());

-- List item 5: 1. Make an appointment with a friendly person....
INSERT INTO component_list (content) VALUES ('1. Make an appointment with a friendly person.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Appreciate the support of others' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: 2. Present your presentation or concept....
INSERT INTO component_list (content) VALUES ('2. Present your presentation or concept.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Appreciate the support of others' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- List item 7: 3. Ask for feedback and thank for the support....
INSERT INTO component_list (content) VALUES ('3. Ask for feedback and thank for the support.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Appreciate the support of others' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 7, LAST_INSERT_ID());

-- Component 8 for Card 7
INSERT INTO component_last_messages (content) VALUES ('Next step - meeting with friend! Enjoy ;-)');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Appreciate the support of others' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 8, LAST_INSERT_ID());

-- ============================================
-- Card 8
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 8, 'The peace of mind before the public speaking', NULL, NULL, NULL);

-- Component 1 for Card 8
INSERT INTO component_title (content) VALUES ('The peace of mind before the public speaking');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The peace of mind before the public speaking' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 8
INSERT INTO component_text (content) VALUES ('Mental preparation for presentations is key. It''s important to ensure your comfort.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The peace of mind before the public speaking' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 8
INSERT INTO component_open_questions (question) VALUES ('What do you need for mental comfort before and during the presentation?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The peace of mind before the public speaking' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 3, LAST_INSERT_ID());

-- Component 4 for Card 8
INSERT INTO component_last_messages (content) VALUES ('Mental peace strengthens self-confidence. Go to the next step.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The peace of mind before the public speaking' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 4, LAST_INSERT_ID());

-- ============================================
-- Card 9
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 9, 'A simple exercise to calm down', NULL, NULL, NULL);

-- Component 1 for Card 9
INSERT INTO component_title (content) VALUES ('A simple exercise to calm down');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'A simple exercise to calm down' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 9
INSERT INTO component_text (content) VALUES ('If you''re stressed, sit in a quiet place and breathe deeply and calmly. This signals to your body that everything is okay. Remember that the universe is on your side and that you''re prepared.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'A simple exercise to calm down' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 9
INSERT INTO component_open_questions (question) VALUES ('Imagine that your speech is over. You did great and people are very interested - how do you feel then?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'A simple exercise to calm down' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 3, LAST_INSERT_ID());

-- Component 4 for Card 9
INSERT INTO component_last_messages (content) VALUES ('Good job - you take care of yourself :-) !');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'A simple exercise to calm down' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 4, LAST_INSERT_ID());

-- ============================================
-- Card 10
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 10, 'Feel good in your style', NULL, NULL, NULL);

-- Component 1 for Card 10
INSERT INTO component_title (content) VALUES ('Feel good in your style');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Feel good in your style' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 10
INSERT INTO component_text (content) VALUES ('People will be looking at you during your presentation. It''s important that you feel comfortable in your outfit. Plan your outfit so that it suits the occasion and reflects your personality. Don''t leave it to the last minute.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Feel good in your style' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 10
INSERT INTO component_open_questions (question) VALUES ('How do you want to present yourself? How do you want to be perceived?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Feel good in your style' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 3, LAST_INSERT_ID());

-- Component 4 for Card 10
INSERT INTO component_last_messages (content) VALUES ('Get yourself a nice outfit - just to feel the way you want.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Feel good in your style' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 4, LAST_INSERT_ID());

-- ============================================
-- Card 11
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 11, 'Check if you are ready', 'What will you apply from this lesson in the future?', NULL, NULL);

-- Component 1 for Card 11
INSERT INTO component_title (content) VALUES ('Check if you are ready');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Check if you are ready' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 11
INSERT INTO component_text (content) VALUES ('Take a moment with yourself. Review everything you''ve written down in this lesson. Consider whether you need anything else. If you''d like more information, visit the ElevateHer platform.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Check if you are ready' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 11
INSERT INTO component_subtitle (content) VALUES ('What will you apply from this lesson in the future?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Check if you are ready' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'subtitle', 3, LAST_INSERT_ID());

-- Component 4 for Card 11

-- List item 4: Make sure you know:...
INSERT INTO component_list (content) VALUES ('Make sure you know:');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Check if you are ready' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 4, LAST_INSERT_ID());

-- List item 5: 1. What is your goal and intention?...
INSERT INTO component_list (content) VALUES ('1. What is your goal and intention?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Check if you are ready' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: 2. Do you know what you will say, how, and in what...
INSERT INTO component_list (content) VALUES ('2. Do you know what you will say, how, and in what order?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Check if you are ready' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- List item 7: 3. How will you ensure your peace of mind and how ...
INSERT INTO component_list (content) VALUES ('3. How will you ensure your peace of mind and how will you present yourself?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Check if you are ready' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 7, LAST_INSERT_ID());

-- Component 8 for Card 11
INSERT INTO component_last_messages (content) VALUES ('Congratulations! Great job! See you in the next lesson.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Check if you are ready' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 8, LAST_INSERT_ID());

-- ============================================
-- End of generated queries
-- ============================================
