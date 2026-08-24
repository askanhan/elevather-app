-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:06.345600
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Course: Public speaking - staying strong in the spotlight
-- ============================================

-- Category: Public speaking
-- Check/Create category 'Public speaking'
INSERT IGNORE INTO module_category (title, description, created_at) VALUES ('Public speaking', 'test description', '2026-08-23 19:54:06.342102');

-- Module creation with automatic category lookup
INSERT INTO module (module_category_id, day_number, title, description, target_audience, estimated_duration, created_at) VALUES ((SELECT id FROM module_category WHERE title = 'Public speaking'), 10, 'Public speaking - staying strong in the spotlight', 'How to keep the vibe and positive attitude during a public speaking, how to handle difficulties and demanding audience, why it is important to analyse your experiences.', 'women learners, leaders', 20, '2026-08-23 19:54:06.342113');

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight'), 1, 'Tame the space', NULL, NULL, NULL);

-- Component 1 for Card 1
INSERT INTO component_title (content) VALUES ('Tame the space');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Tame the space' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 1
INSERT INTO component_text (content) VALUES ('For your peace of mind, find out what the venue looks like and what the technical conditions are. It''s always a good idea to arrive early to familiarize yourself with the venue and make any necessary changes.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Tame the space' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 1
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('put directly the exact name of the image file and the image format. e.g : generated_image 8.png', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Tame the space' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'image', 3, LAST_INSERT_ID());

-- Component 4 for Card 1
INSERT INTO component_open_questions (question) VALUES ('Do you know how to take advantage of the advantages of your venue?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Tame the space' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'open question', 4, LAST_INSERT_ID());

-- Component 5 for Card 1

-- List item 5: Hints - checking the room:...
INSERT INTO component_list (content) VALUES ('Hints - checking the room:');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Tame the space' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: 1. Where you are performing from and whether the l...
INSERT INTO component_list (content) VALUES ('1. Where you are performing from and whether the light is not blinding you.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Tame the space' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- List item 7: 2. If you can be seen and heard well....
INSERT INTO component_list (content) VALUES ('2. If you can be seen and heard well.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Tame the space' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 7, LAST_INSERT_ID());

-- List item 8: 3. If the equipment works,...
INSERT INTO component_list (content) VALUES ('3. If the equipment works,');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Tame the space' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 8, LAST_INSERT_ID());

-- Component 9 for Card 1
INSERT INTO component_last_messages (content) VALUES ('The first step is behind you, it''s time for the next one ;-)');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Tame the space' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'last message', 9, LAST_INSERT_ID());

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight'), 2, 'Contact with the audience', NULL, NULL, NULL);

-- Component 1 for Card 2
INSERT INTO component_title (content) VALUES ('Contact with the audience');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Contact with the audience' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 2
INSERT INTO component_text (content) VALUES ('Remember, you only make a first impression once. The beginning is the moment you connect with your audience and pique their curiosity to keep listening.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Contact with the audience' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 2
INSERT INTO component_open_questions (question) VALUES ('Do you know well how you will start your speech?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Contact with the audience' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'open question', 3, LAST_INSERT_ID());

-- Component 4 for Card 2

-- List item 4: Here are some tips:...
INSERT INTO component_list (content) VALUES ('Here are some tips:');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Contact with the audience' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 4, LAST_INSERT_ID());

-- List item 5: 1. Start as planned....
INSERT INTO component_list (content) VALUES ('1. Start as planned.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Contact with the audience' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: 2. Greet and show your satisfaction with the meeti...
INSERT INTO component_list (content) VALUES ('2. Greet and show your satisfaction with the meeting.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Contact with the audience' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- List item 7: 3. Maintain eye contact with the room....
INSERT INTO component_list (content) VALUES ('3. Maintain eye contact with the room.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Contact with the audience' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 7, LAST_INSERT_ID());

-- List item 8: 4. Direct your gaze to different parts of the audi...
INSERT INTO component_list (content) VALUES ('4. Direct your gaze to different parts of the audience.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Contact with the audience' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 8, LAST_INSERT_ID());

-- List item 9: 5. Remember to smile and be friendly....
INSERT INTO component_list (content) VALUES ('5. Remember to smile and be friendly.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Contact with the audience' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 9, LAST_INSERT_ID());

-- List item 10: 6. Remind the meeting purpose....
INSERT INTO component_list (content) VALUES ('6. Remind the meeting purpose.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Contact with the audience' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 10, LAST_INSERT_ID());

-- List item 11: 7.Propose meeting rules....
INSERT INTO component_list (content) VALUES ('7.Propose meeting rules.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Contact with the audience' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 11, LAST_INSERT_ID());

-- Component 12 for Card 2
INSERT INTO component_last_messages (content) VALUES ('Well done! After a good start, the rest comes easier!');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Contact with the audience' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'last message', 12, LAST_INSERT_ID());

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight'), 3, 'The non-verbal messages', NULL, NULL, NULL);

-- Component 1 for Card 3
INSERT INTO component_title (content) VALUES ('The non-verbal messages');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The non-verbal messages' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 3
INSERT INTO component_text (content) VALUES ('Body language and tone of voice communicate more than words and are read more quickly as subliminal information. Don''t ignore this and pay attention to how you deliver your presentation.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The non-verbal messages' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 3
INSERT INTO component_open_questions (question) VALUES ('Are you aware of how you speak to people?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The non-verbal messages' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'open question', 3, LAST_INSERT_ID());

-- Component 4 for Card 3

-- List item 4: Remember a few things:...
INSERT INTO component_list (content) VALUES ('Remember a few things:');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The non-verbal messages' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 4, LAST_INSERT_ID());

-- List item 5: 1. Always speak facing the audience....
INSERT INTO component_list (content) VALUES ('1. Always speak facing the audience.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The non-verbal messages' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: 2. Do not turn around to read slides from the wall...
INSERT INTO component_list (content) VALUES ('2. Do not turn around to read slides from the wall!');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The non-verbal messages' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- List item 7: 3. Maintain an open body posture....
INSERT INTO component_list (content) VALUES ('3. Maintain an open body posture.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The non-verbal messages' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 7, LAST_INSERT_ID());

-- List item 8: 4. Do not cross your arms and do not cover yoursel...
INSERT INTO component_list (content) VALUES ('4. Do not cross your arms and do not cover yourself.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The non-verbal messages' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 8, LAST_INSERT_ID());

-- List item 9: 5. Stand firmly on your feet - avoid rocking and r...
INSERT INTO component_list (content) VALUES ('5. Stand firmly on your feet - avoid rocking and running around the room.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The non-verbal messages' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 9, LAST_INSERT_ID());

-- List item 10: 6.  Speak clearly-don't purr. Smile if the context...
INSERT INTO component_list (content) VALUES ('6.  Speak clearly-don''t purr. Smile if the context allows it.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The non-verbal messages' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 10, LAST_INSERT_ID());

-- List item 11: 7. Speak from the 1/3 of the length of the speakin...
INSERT INTO component_list (content) VALUES ('7. Speak from the 1/3 of the length of the speaking space, not in the very center.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The non-verbal messages' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 11, LAST_INSERT_ID());

-- Component 12 for Card 3
INSERT INTO component_last_messages (content) VALUES ('Now you understand more. Time for the next step :-)');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The non-verbal messages' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'last message', 12, LAST_INSERT_ID());

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight'), 4, 'Why is water so important?', NULL, NULL, NULL);

-- Component 1 for Card 4
INSERT INTO component_title (content) VALUES ('Why is water so important?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Why is water so important?' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 4
INSERT INTO component_text (content) VALUES ('Did you know that drinking water lowers your body''s stress levels, hydrates your brain, and allows it to function efficiently? During a presentation, water provides an opportunity to pause briefly and hydrate your throat.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Why is water so important?' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 4
INSERT INTO component_quote (content, author) VALUES ('„Water helps you think faster and your stress levels decrease”', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Why is water so important?' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 4
INSERT INTO component_open_questions (question) VALUES ('Have you taken care of your brain? Do you have water with you?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Why is water so important?' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'open question', 4, LAST_INSERT_ID());

-- Component 5 for Card 4
INSERT INTO component_last_messages (content) VALUES ('You''re less stressed now, let''s move on!');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Why is water so important?' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'last message', 5, LAST_INSERT_ID());

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight'), 5, 'Reducing stress', NULL, NULL, NULL);

-- Component 1 for Card 5
INSERT INTO component_title (content) VALUES ('Reducing stress');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Reducing stress' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 5
INSERT INTO component_text (content) VALUES ('Remember that stress levels may be highest before your presentation. Once you get going, your stress will decrease or disappear completely. You''ll be in the thick of it. However, it''s important to take care of yourself during your presentation.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Reducing stress' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 5
INSERT INTO component_open_questions (question) VALUES ('Can you calm down on your own?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Reducing stress' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'open question', 3, LAST_INSERT_ID());

-- Component 4 for Card 5

-- List item 4: Some hints for you:...
INSERT INTO component_list (content) VALUES ('Some hints for you:');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Reducing stress' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 4, LAST_INSERT_ID());

-- List item 5: 1. Before your speech, take a few deep, calm breat...
INSERT INTO component_list (content) VALUES ('1. Before your speech, take a few deep, calm breaths.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Reducing stress' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: 2. During your speech, remember to breathe ;-)....
INSERT INTO component_list (content) VALUES ('2. During your speech, remember to breathe ;-).');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Reducing stress' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- List item 7: 3. Give yourself permission for short moments of s...
INSERT INTO component_list (content) VALUES ('3. Give yourself permission for short moments of silence.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Reducing stress' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 7, LAST_INSERT_ID());

-- List item 8: 4. Sip water during the presentation....
INSERT INTO component_list (content) VALUES ('4. Sip water during the presentation.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Reducing stress' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 8, LAST_INSERT_ID());

-- List item 9: 5. Maintain eye contact with the audience....
INSERT INTO component_list (content) VALUES ('5. Maintain eye contact with the audience.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Reducing stress' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 9, LAST_INSERT_ID());

-- List item 10: 6. Smile....
INSERT INTO component_list (content) VALUES ('6. Smile.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Reducing stress' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 10, LAST_INSERT_ID());

-- List item 11: 7. Have notes with you....
INSERT INTO component_list (content) VALUES ('7. Have notes with you.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Reducing stress' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 11, LAST_INSERT_ID());

-- Component 12 for Card 5
INSERT INTO component_last_messages (content) VALUES ('Calm down and let''s move on :-)');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Reducing stress' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'last message', 12, LAST_INSERT_ID());

-- ============================================
-- Card 6
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight'), 6, 'Mistakes are not the end of the world', NULL, NULL, NULL);

-- Component 1 for Card 6
INSERT INTO component_title (content) VALUES ('Mistakes are not the end of the world');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Mistakes are not the end of the world' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 6
INSERT INTO component_text (content) VALUES ('You might make a mistake, get tangled... Oh well! You''re human. Usually, only you know you made a mistake, that something was supposed to be a little different ;-). Give yourself a chance. Gracefully return to continuing your presentation.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Mistakes are not the end of the world' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 6
INSERT INTO component_quote (content, author) VALUES ('„She who makes no mistakes, does nothing"', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Mistakes are not the end of the world' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 6
INSERT INTO component_open_questions (question) VALUES ('Do you have notes with you so you can refer back to your plan if necessary?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Mistakes are not the end of the world' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'open question', 4, LAST_INSERT_ID());

-- Component 5 for Card 6

-- List item 5: Here are some tips:...
INSERT INTO component_list (content) VALUES ('Here are some tips:');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Mistakes are not the end of the world' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: 1. Don't make excuses....
INSERT INTO component_list (content) VALUES ('1. Don''t make excuses.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Mistakes are not the end of the world' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- List item 7: 2. Don't announce that you were supposed to do som...
INSERT INTO component_list (content) VALUES ('2. Don''t announce that you were supposed to do something differently if no one knows.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Mistakes are not the end of the world' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 7, LAST_INSERT_ID());

-- List item 8: 3. Move on....
INSERT INTO component_list (content) VALUES ('3. Move on.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Mistakes are not the end of the world' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 8, LAST_INSERT_ID());

-- List item 9: 4. If necessary, apologize for a slip of the tongu...
INSERT INTO component_list (content) VALUES ('4. If necessary, apologize for a slip of the tongue, and continue.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Mistakes are not the end of the world' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 9, LAST_INSERT_ID());

-- Component 10 for Card 6
INSERT INTO component_last_messages (content) VALUES ('It''s good, let''s move on!');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Mistakes are not the end of the world' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'last message', 10, LAST_INSERT_ID());

-- ============================================
-- Card 7
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight'), 7, 'Time for questions and discussion', NULL, NULL, NULL);

-- Component 1 for Card 7
INSERT INTO component_title (content) VALUES ('Time for questions and discussion');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Time for questions and discussion' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 7
INSERT INTO component_text (content) VALUES ('Many people fear not knowing the answers to questions. It''s not the end of the world. However, good preparation alleviates this fear. If you''re new to public speaking, it''s a good idea to reserve time for questions and discussion at the end.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Time for questions and discussion' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 7
INSERT INTO component_open_questions (question) VALUES ('Czy boisz się jakiś pytań?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Time for questions and discussion' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'open question', 3, LAST_INSERT_ID());

-- Component 4 for Card 7

-- List item 4: Tips for you:...
INSERT INTO component_list (content) VALUES ('Tips for you:');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Time for questions and discussion' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 4, LAST_INSERT_ID());

-- List item 5: 1. Preaper well ;-)....
INSERT INTO component_list (content) VALUES ('1. Preaper well ;-).');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Time for questions and discussion' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: 2. Imagine the questions you are afraid of and ans...
INSERT INTO component_list (content) VALUES ('2. Imagine the questions you are afraid of and answer them before your presentation.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Time for questions and discussion' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- List item 7: 3. If you don't know the answer say: "Ohh, that's ...
INSERT INTO component_list (content) VALUES ('3. If you don''t know the answer say: "Ohh, that''s a great question, I don''t know the answer right now, but after the meeting, as soon as I figure it out, I''ll send it to you”.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Time for questions and discussion' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 7, LAST_INSERT_ID());

-- Component 8 for Card 7
INSERT INTO component_last_messages (content) VALUES ('Congratulations—you''ve piqued their interest! Next step :-).');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Time for questions and discussion' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'last message', 8, LAST_INSERT_ID());

-- ============================================
-- Card 8
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight'), 8, 'What to do about rude behavior?', NULL, NULL, NULL);

-- Component 1 for Card 8
INSERT INTO component_title (content) VALUES ('What to do about rude behavior?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What to do about rude behavior?' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 8
INSERT INTO component_text (content) VALUES ('Sometimes there are rude participants, or even provocateurs. This can be a difficult situation for you. It''s important to feel like you know what to do.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What to do about rude behavior?' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 8
INSERT INTO component_open_questions (question) VALUES ('Can I cope with rude behavior?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What to do about rude behavior?' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'open question', 3, LAST_INSERT_ID());

-- Component 4 for Card 8

-- List item 4: How to cope?...
INSERT INTO component_list (content) VALUES ('How to cope?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What to do about rude behavior?' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 4, LAST_INSERT_ID());

-- List item 5: 1. Avoid provocations - do not argue....
INSERT INTO component_list (content) VALUES ('1. Avoid provocations - do not argue.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What to do about rude behavior?' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: 2. Refer to the rules of the meeting....
INSERT INTO component_list (content) VALUES ('2. Refer to the rules of the meeting.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What to do about rude behavior?' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- List item 7: 3. Set boundaries - say that you will only talk in...
INSERT INTO component_list (content) VALUES ('3. Set boundaries - say that you will only talk in a respectful and polite manner.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What to do about rude behavior?' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 7, LAST_INSERT_ID());

-- List item 8: 4. In the worst case, stop speaking, ask the organ...
INSERT INTO component_list (content) VALUES ('4. In the worst case, stop speaking, ask the organizers for support.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What to do about rude behavior?' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'list', 8, LAST_INSERT_ID());

-- Component 9 for Card 8
INSERT INTO component_last_messages (content) VALUES ('You''re in control. ;-) Let''s move on.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What to do about rude behavior?' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'last message', 9, LAST_INSERT_ID());

-- ============================================
-- Card 9
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight'), 9, '„The freshness effect” i.e. the ending', NULL, NULL, NULL);

-- Component 1 for Card 9
INSERT INTO component_title (content) VALUES ('„The freshness effect” i.e. the ending');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = '„The freshness effect” i.e. the ending' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 9
INSERT INTO component_text (content) VALUES ('The last thing is remembered well, so put some effort into summarizing. Also, thank your audience for the meeting and their attention.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = '„The freshness effect” i.e. the ending' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 9
INSERT INTO component_quote (content, author) VALUES ('"Maintain a good impression with an elegant ending.”', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = '„The freshness effect” i.e. the ending' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 9
INSERT INTO component_open_questions (question) VALUES ('What I want to leave in the memory and hearts of my audience?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = '„The freshness effect” i.e. the ending' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'open question', 4, LAST_INSERT_ID());

-- Component 5 for Card 9
INSERT INTO component_last_messages (content) VALUES ('Good job! :-)');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = '„The freshness effect” i.e. the ending' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'last message', 5, LAST_INSERT_ID());

-- ============================================
-- Card 10
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight'), 10, 'Feedback analysis', NULL, NULL, NULL);

-- Component 1 for Card 10
INSERT INTO component_title (content) VALUES ('Feedback analysis');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Feedback analysis' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 10
INSERT INTO component_text (content) VALUES ('It''s good to learn through your own experience and feedback from others. Ask participants for feedback. You can use simple methods like surveys or short post-meeting discussions. Also, analyze your own feelings after the presentation and those of your friends in the room.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Feedback analysis' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 10
INSERT INTO component_quote (content, author) VALUES ('"Feedback is an opportunity to develop, not to clip your wings."', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Feedback analysis' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 10
INSERT INTO component_open_questions (question) VALUES ('What am I happy with?  What will I do differently next time?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Feedback analysis' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'open question', 4, LAST_INSERT_ID());

-- Component 5 for Card 10
INSERT INTO component_last_messages (content) VALUES ('You got it! Time for the final step.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Feedback analysis' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'last message', 5, LAST_INSERT_ID());

-- ============================================
-- Card 11
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight'), 11, 'To make a long story short…', NULL, NULL, NULL);

-- Component 1 for Card 11
INSERT INTO component_title (content) VALUES ('To make a long story short…');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'To make a long story short…' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 11
INSERT INTO component_video (video_url, video_duration_est, video_alt, video_description) VALUES ('https://drive.google.com/file/d/11N_dDSl4A-dZ45mjqrViyMv6oK8ChwcY/view?usp=drive_link', NULL, NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'To make a long story short…' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'video', 2, LAST_INSERT_ID());

-- Component 3 for Card 11
INSERT INTO component_open_questions (question) VALUES ('What will your speeches look like after these lessons?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'To make a long story short…' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'open question', 3, LAST_INSERT_ID());

-- Component 4 for Card 11
INSERT INTO component_last_messages (content) VALUES ('Congratulations! Great job!');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'To make a long story short…' AND owner_id = (SELECT id FROM module WHERE title = 'Public speaking - staying strong in the spotlight') LIMIT 1), 'last message', 4, LAST_INSERT_ID());

-- ============================================
-- End of generated queries
-- ============================================
