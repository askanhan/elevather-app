-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:10.748715
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Simulator: Public Speaking
-- ============================================
INSERT INTO simulator (title, description, level, localisation, estimated_duration, created_at) VALUES ('Public Speaking', 'No description', 'basic', 'work/community', 10, '2026-08-23 19:54:10.747766');

-- Simulator Tags
INSERT INTO simulator_tag (name) VALUES ('leadership');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'Public Speaking'), (SELECT id FROM simulator_tag WHERE name = 'leadership' LIMIT 1));
INSERT INTO simulator_tag (name) VALUES ('public speaking');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'Public Speaking'), (SELECT id FROM simulator_tag WHERE name = 'public speaking' LIMIT 1));
INSERT INTO simulator_tag (name) VALUES ('charisma');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'Public Speaking'), (SELECT id FROM simulator_tag WHERE name = 'charisma' LIMIT 1));
INSERT INTO simulator_tag (name) VALUES ('self-confidence');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'Public Speaking'), (SELECT id FROM simulator_tag WHERE name = 'self-confidence' LIMIT 1));

-- Simulator Metrics
INSERT INTO simulator_metric (name) VALUES ('assertiveness');
INSERT INTO simulator_contains_metric (simulator_id, metric_id) VALUES ((SELECT id FROM simulator WHERE title = 'Public Speaking'), (SELECT id FROM simulator_metric WHERE name = 'assertiveness' LIMIT 1));
INSERT INTO simulator_metric (name) VALUES ('self-confidence');
INSERT INTO simulator_contains_metric (simulator_id, metric_id) VALUES ((SELECT id FROM simulator WHERE title = 'Public Speaking'), (SELECT id FROM simulator_metric WHERE name = 'self-confidence' LIMIT 1));
INSERT INTO simulator_metric (name) VALUES ('composure');
INSERT INTO simulator_contains_metric (simulator_id, metric_id) VALUES ((SELECT id FROM simulator WHERE title = 'Public Speaking'), (SELECT id FROM simulator_metric WHERE name = 'composure' LIMIT 1));

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'Public Speaking'), 1, '1.Approach', 'Attitude is everything', NULL, NULL);

-- Component 1 for Card 0
INSERT INTO component_text (content) VALUES ('You go into the conference room to present your speech and the projector doesn''t work, even though it was working before. You can''t use the presentation.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = '1.Approach' AND owner_id = (SELECT id FROM simulator WHERE title = 'Public Speaking') LIMIT 1), 'text', 1, LAST_INSERT_ID());

-- Component 2 for Card 0
INSERT INTO component_mcq (question) VALUES ('You go into the conference room to present your speech and the projector doesn''t work, even though it was working before. You can''t use the presentation.');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You go into the conference room to present your speech and the projector doesn''t work, even though it was working before. You can''t use the presentation.' ORDER BY id DESC LIMIT 1), 'You are very nervous, you show embarrassment, you have no plan B, you are waiting for the projector to be repaired', 'You are losing in the eyes of the audience, you did not take care of the recipients');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You go into the conference room to present your speech and the projector doesn''t work, even though it was working before. You can''t use the presentation.') 
     AND option_text = 'You are very nervous, you show embarrassment, you have no plan B, you are waiting for the projector to be repaired' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'self-confidence -' LIMIT 1), 1);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You go into the conference room to present your speech and the projector doesn''t work, even though it was working before. You can''t use the presentation.') 
     AND option_text = 'You are very nervous, you show embarrassment, you have no plan B, you are waiting for the projector to be repaired' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'composure -' LIMIT 1), 1);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You go into the conference room to present your speech and the projector doesn''t work, even though it was working before. You can''t use the presentation.' ORDER BY id DESC LIMIT 1), 'You contact your audience and inform them that there''s a temporary problem. You ask for their patience. If nothing changes in a minute, you implement plan B.', 'You come across as in control and prepared. People can trust you.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You go into the conference room to present your speech and the projector doesn''t work, even though it was working before. You can''t use the presentation.') 
     AND option_text = 'You contact your audience and inform them that there''s a temporary problem. You ask for their patience. If nothing changes in a minute, you implement plan B.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'self-confidence -' LIMIT 1), 2);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You go into the conference room to present your speech and the projector doesn''t work, even though it was working before. You can''t use the presentation.') 
     AND option_text = 'You contact your audience and inform them that there''s a temporary problem. You ask for their patience. If nothing changes in a minute, you implement plan B.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'composure -' LIMIT 1), 3);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = '1.Approach' AND owner_id = (SELECT id FROM simulator WHERE title = 'Public Speaking') LIMIT 1), 'mcq', 2, LAST_INSERT_ID());

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'Public Speaking'), 2, '2. Approach', 'Setting boundaries', NULL, NULL);

-- Component 1 for Card 1
INSERT INTO component_text (content) VALUES ('During a meeting, someone in the room interrupts you, makes loud comments, and ignores others');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = '2. Approach' AND owner_id = (SELECT id FROM simulator WHERE title = 'Public Speaking') LIMIT 1), 'text', 1, LAST_INSERT_ID());

-- Component 2 for Card 1
INSERT INTO component_mcq (question) VALUES ('During a meeting, someone in the room interrupts you, makes loud comments, and ignores others');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'During a meeting, someone in the room interrupts you, makes loud comments, and ignores others' ORDER BY id DESC LIMIT 1), 'You pretend you didn''t hear it, try to continue the meeting, and hope that the person will calm down.', 'You are encouraging the rude person to continue their actions.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'During a meeting, someone in the room interrupts you, makes loud comments, and ignores others') 
     AND option_text = 'You pretend you didn''t hear it, try to continue the meeting, and hope that the person will calm down.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'assertiveness -' LIMIT 1), 0);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'During a meeting, someone in the room interrupts you, makes loud comments, and ignores others') 
     AND option_text = 'You pretend you didn''t hear it, try to continue the meeting, and hope that the person will calm down.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'self-confidence - -' LIMIT 1), 1);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'During a meeting, someone in the room interrupts you, makes loud comments, and ignores others' ORDER BY id DESC LIMIT 1), 'You intervene. You ask for respect for the meeting rules and other people.', 'This way, you''re setting a boundary. You''re demonstrating that you''re capable of intervening.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'During a meeting, someone in the room interrupts you, makes loud comments, and ignores others') 
     AND option_text = 'You intervene. You ask for respect for the meeting rules and other people.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'assertiveness' LIMIT 1), -3);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'During a meeting, someone in the room interrupts you, makes loud comments, and ignores others') 
     AND option_text = 'You intervene. You ask for respect for the meeting rules and other people.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'self-confidence -' LIMIT 1), 3);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = '2. Approach' AND owner_id = (SELECT id FROM simulator WHERE title = 'Public Speaking') LIMIT 1), 'mcq', 2, LAST_INSERT_ID());

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'Public Speaking'), 3, '3. Approach', 'Everything is possible', NULL, NULL);

-- Component 1 for Card 2
INSERT INTO component_text (content) VALUES ('A participant asks you a surprising question to which you don''t know the answer.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = '3. Approach' AND owner_id = (SELECT id FROM simulator WHERE title = 'Public Speaking') LIMIT 1), 'text', 1, LAST_INSERT_ID());

-- Component 2 for Card 2
INSERT INTO component_mcq (question) VALUES ('A participant asks you a surprising question to which you don''t know the answer.');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'A participant asks you a surprising question to which you don''t know the answer.' ORDER BY id DESC LIMIT 1), 'You get nervous, you think it''s a shame that you don''t know the answer, you show embarrassment', 'Some people are starting to feel sorry for you for being so upset.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'A participant asks you a surprising question to which you don''t know the answer.') 
     AND option_text = 'You get nervous, you think it''s a shame that you don''t know the answer, you show embarrassment' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'assertiveness -' LIMIT 1), 1);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'A participant asks you a surprising question to which you don''t know the answer.') 
     AND option_text = 'You get nervous, you think it''s a shame that you don''t know the answer, you show embarrassment' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'self-confidence -' LIMIT 1), 0);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'A participant asks you a surprising question to which you don''t know the answer.' ORDER BY id DESC LIMIT 1), 'You thank the person for their interesting question. You say it surprised you. You promise to check it out and get back to the audience with the answer after the meeting.', 'This attitude shows that you are confident and that you can cope with difficult situations.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'A participant asks you a surprising question to which you don''t know the answer.') 
     AND option_text = 'You thank the person for their interesting question. You say it surprised you. You promise to check it out and get back to the audience with the answer after the meeting.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'assertiveness -' LIMIT 1), 2);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'A participant asks you a surprising question to which you don''t know the answer.') 
     AND option_text = 'You thank the person for their interesting question. You say it surprised you. You promise to check it out and get back to the audience with the answer after the meeting.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'self-confidence -' LIMIT 1), 3);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = '3. Approach' AND owner_id = (SELECT id FROM simulator WHERE title = 'Public Speaking') LIMIT 1), 'mcq', 2, LAST_INSERT_ID());

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'Public Speaking'), 4, '1.Non-verbal messages', 'Look at  the people', NULL, NULL);

-- Component 1 for Card 3
INSERT INTO component_text (content) VALUES ('Your presentation appears on the screen behind you');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = '1.Non-verbal messages' AND owner_id = (SELECT id FROM simulator WHERE title = 'Public Speaking') LIMIT 1), 'text', 1, LAST_INSERT_ID());

-- Component 2 for Card 3
INSERT INTO component_mcq (question) VALUES ('Your presentation appears on the screen behind you');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Your presentation appears on the screen behind you' ORDER BY id DESC LIMIT 1), 'You turn your back to read the slides or you stand sideways to the audience.', 'Talking with your back to people shows poor preparation');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Your presentation appears on the screen behind you') 
     AND option_text = 'You turn your back to read the slides or you stand sideways to the audience.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'composure -' LIMIT 1), 1);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Your presentation appears on the screen behind you') 
     AND option_text = 'You turn your back to read the slides or you stand sideways to the audience.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'self-confidence -' LIMIT 1), 1);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Your presentation appears on the screen behind you' ORDER BY id DESC LIMIT 1), 'You have the screen or notes in front of you so that you don''t have to stand back', 'A simple solution that makes a professional impression');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Your presentation appears on the screen behind you') 
     AND option_text = 'You have the screen or notes in front of you so that you don''t have to stand back' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'composure  -' LIMIT 1), 2);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Your presentation appears on the screen behind you') 
     AND option_text = 'You have the screen or notes in front of you so that you don''t have to stand back' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'self-confidence -' LIMIT 1), 3);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = '1.Non-verbal messages' AND owner_id = (SELECT id FROM simulator WHERE title = 'Public Speaking') LIMIT 1), 'mcq', 2, LAST_INSERT_ID());

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'Public Speaking'), 5, '2.Non-verbal messages', 'Confident voice', NULL, NULL);

-- Component 1 for Card 4
INSERT INTO component_text (content) VALUES ('You''re telling an important story that has a lot of difficult threads.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = '2.Non-verbal messages' AND owner_id = (SELECT id FROM simulator WHERE title = 'Public Speaking') LIMIT 1), 'text', 1, LAST_INSERT_ID());

-- Component 2 for Card 4
INSERT INTO component_mcq (question) VALUES ('You''re telling an important story that has a lot of difficult threads.');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You''re telling an important story that has a lot of difficult threads.' ORDER BY id DESC LIMIT 1), 'You want to get through this as quickly as possible. You don''t like talking about difficult things.', 'People may interpret this as a lack of courage when it comes to difficult topics.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You''re telling an important story that has a lot of difficult threads.') 
     AND option_text = 'You want to get through this as quickly as possible. You don''t like talking about difficult things.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'composure' LIMIT 1), -1);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You''re telling an important story that has a lot of difficult threads.') 
     AND option_text = 'You want to get through this as quickly as possible. You don''t like talking about difficult things.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'assertiveness -' LIMIT 1), 0);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You''re telling an important story that has a lot of difficult threads.' ORDER BY id DESC LIMIT 1), 'You speak calmly, you divide the story into stages, you want people to understand.', 'People see that you have the courage to raise difficult issues.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You''re telling an important story that has a lot of difficult threads.') 
     AND option_text = 'You speak calmly, you divide the story into stages, you want people to understand.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'composure -' LIMIT 1), 3);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You''re telling an important story that has a lot of difficult threads.') 
     AND option_text = 'You speak calmly, you divide the story into stages, you want people to understand.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'assertiveness -' LIMIT 1), 2);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = '2.Non-verbal messages' AND owner_id = (SELECT id FROM simulator WHERE title = 'Public Speaking') LIMIT 1), 'mcq', 2, LAST_INSERT_ID());

-- ============================================
-- Card 6
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'Public Speaking'), 6, '3. Non-verbal messages', 'Body posture', NULL, NULL);

-- Component 1 for Card 5
INSERT INTO component_text (content) VALUES ('You are answering very difficult questions during an important meeting.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = '3. Non-verbal messages' AND owner_id = (SELECT id FROM simulator WHERE title = 'Public Speaking') LIMIT 1), 'text', 1, LAST_INSERT_ID());

-- Component 2 for Card 5
INSERT INTO component_mcq (question) VALUES ('You are answering very difficult questions during an important meeting.');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You are answering very difficult questions during an important meeting.' ORDER BY id DESC LIMIT 1), 'You cringe, cross your arms, want to hide behind something.', 'Your posture shows uncertainty and submission.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You are answering very difficult questions during an important meeting.') 
     AND option_text = 'You cringe, cross your arms, want to hide behind something.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-confidence -' LIMIT 1), 0);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You are answering very difficult questions during an important meeting.') 
     AND option_text = 'You cringe, cross your arms, want to hide behind something.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'composure -' LIMIT 1), 1);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You are answering very difficult questions during an important meeting.' ORDER BY id DESC LIMIT 1), 'You straighten your back, stand firmly on your feet, adopt an open posture, and hold your head high.', 'You clearly know what you''re talking about and can be trusted.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You are answering very difficult questions during an important meeting.') 
     AND option_text = 'You straighten your back, stand firmly on your feet, adopt an open posture, and hold your head high.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-confidence -' LIMIT 1), 3);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You are answering very difficult questions during an important meeting.') 
     AND option_text = 'You straighten your back, stand firmly on your feet, adopt an open posture, and hold your head high.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'composure -' LIMIT 1), 3);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = '3. Non-verbal messages' AND owner_id = (SELECT id FROM simulator WHERE title = 'Public Speaking') LIMIT 1), 'mcq', 2, LAST_INSERT_ID());

-- ============================================
-- Card 7
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'Public Speaking'), 7, '1.Flexibility', 'Hit the ball', NULL, NULL);

-- Component 1 for Card 6
INSERT INTO component_text (content) VALUES ('Suddenly, a comment appears from the audience that perfectly fits your speech.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = '1.Flexibility' AND owner_id = (SELECT id FROM simulator WHERE title = 'Public Speaking') LIMIT 1), 'text', 1, LAST_INSERT_ID());

-- Component 2 for Card 6
INSERT INTO component_mcq (question) VALUES ('Suddenly, a comment appears from the audience that perfectly fits your speech.');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Suddenly, a comment appears from the audience that perfectly fits your speech.' ORDER BY id DESC LIMIT 1), 'You know this comment is appropriate, but you don''t address it because you''re afraid of disrupting your plan.', 'Sometimes it''s worth taking advantage of a moment that allows you to connect with your audience.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Suddenly, a comment appears from the audience that perfectly fits your speech.') 
     AND option_text = 'You know this comment is appropriate, but you don''t address it because you''re afraid of disrupting your plan.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'assertiveness' LIMIT 1), -1);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Suddenly, a comment appears from the audience that perfectly fits your speech.') 
     AND option_text = 'You know this comment is appropriate, but you don''t address it because you''re afraid of disrupting your plan.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'self-confidence -' LIMIT 1), 1);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Suddenly, a comment appears from the audience that perfectly fits your speech.' ORDER BY id DESC LIMIT 1), 'You skillfully weave this comment into the rest of your speech.', 'It shows that you respond to what people say and that you are in touch.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Suddenly, a comment appears from the audience that perfectly fits your speech.') 
     AND option_text = 'You skillfully weave this comment into the rest of your speech.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'assertiveness -' LIMIT 1), 2);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Suddenly, a comment appears from the audience that perfectly fits your speech.') 
     AND option_text = 'You skillfully weave this comment into the rest of your speech.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'self-confidence' LIMIT 1), -3);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = '1.Flexibility' AND owner_id = (SELECT id FROM simulator WHERE title = 'Public Speaking') LIMIT 1), 'mcq', 2, LAST_INSERT_ID());

-- ============================================
-- Card 8
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'Public Speaking'), 8, '2. Flexibility', 'Stay informed', NULL, NULL);

-- Component 1 for Card 7
INSERT INTO component_text (content) VALUES ('Some surprising social events have just occurred in the city where you are hosting the meeting.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = '2. Flexibility' AND owner_id = (SELECT id FROM simulator WHERE title = 'Public Speaking') LIMIT 1), 'text', 1, LAST_INSERT_ID());

-- Component 2 for Card 7
INSERT INTO component_mcq (question) VALUES ('Some surprising social events have just occurred in the city where you are hosting the meeting.');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Some surprising social events have just occurred in the city where you are hosting the meeting.' ORDER BY id DESC LIMIT 1), 'It has no bearing on your plans for running the meeting, you will not refer to it.', 'To local people, this may seem like arrogance or a lack of orientation.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Some surprising social events have just occurred in the city where you are hosting the meeting.') 
     AND option_text = 'It has no bearing on your plans for running the meeting, you will not refer to it.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'composure -' LIMIT 1), 1);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Some surprising social events have just occurred in the city where you are hosting the meeting.') 
     AND option_text = 'It has no bearing on your plans for running the meeting, you will not refer to it.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'assertivness -' LIMIT 1), 1);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Some surprising social events have just occurred in the city where you are hosting the meeting.' ORDER BY id DESC LIMIT 1), 'You change your speech and refer to these events.', 'It''s clear you want to build a relationship with your audience.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Some surprising social events have just occurred in the city where you are hosting the meeting.') 
     AND option_text = 'You change your speech and refer to these events.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'composure -' LIMIT 1), 3);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Some surprising social events have just occurred in the city where you are hosting the meeting.') 
     AND option_text = 'You change your speech and refer to these events.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'assertivness -' LIMIT 1), 3);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = '2. Flexibility' AND owner_id = (SELECT id FROM simulator WHERE title = 'Public Speaking') LIMIT 1), 'mcq', 2, LAST_INSERT_ID());

-- ============================================
-- Card 9
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'Public Speaking'), 9, '3. Flexibility', 'Spot opportunities', NULL, NULL);

-- Component 1 for Card 8
INSERT INTO component_text (content) VALUES ('The person who gave the presentation before yours presented a completely different approach to the problem you will be talking about.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = '3. Flexibility' AND owner_id = (SELECT id FROM simulator WHERE title = 'Public Speaking') LIMIT 1), 'text', 1, LAST_INSERT_ID());

-- Component 2 for Card 8
INSERT INTO component_mcq (question) VALUES ('The person who gave the presentation before yours presented a completely different approach to the problem you will be talking about.');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'The person who gave the presentation before yours presented a completely different approach to the problem you will be talking about.' ORDER BY id DESC LIMIT 1), 'You don''t care. You want to perform your best, and that''s what matters.', 'You focus on the goal, you don''t want confusion.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'The person who gave the presentation before yours presented a completely different approach to the problem you will be talking about.') 
     AND option_text = 'You don''t care. You want to perform your best, and that''s what matters.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'composure' LIMIT 1), 1);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'The person who gave the presentation before yours presented a completely different approach to the problem you will be talking about.') 
     AND option_text = 'You don''t care. You want to perform your best, and that''s what matters.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'assertiveness -' LIMIT 1), 2);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'The person who gave the presentation before yours presented a completely different approach to the problem you will be talking about.') 
     AND option_text = 'You don''t care. You want to perform your best, and that''s what matters.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'self-confidence -' LIMIT 1), 1);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'The person who gave the presentation before yours presented a completely different approach to the problem you will be talking about.' ORDER BY id DESC LIMIT 1), 'You cleverly refer to the previous presentation and show the advantages of your approach.', 'Some audiences will appreciate your social intelligence and flexibility.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'The person who gave the presentation before yours presented a completely different approach to the problem you will be talking about.') 
     AND option_text = 'You cleverly refer to the previous presentation and show the advantages of your approach.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'composure' LIMIT 1), -3);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'The person who gave the presentation before yours presented a completely different approach to the problem you will be talking about.') 
     AND option_text = 'You cleverly refer to the previous presentation and show the advantages of your approach.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'assertiveness -' LIMIT 1), 3);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'The person who gave the presentation before yours presented a completely different approach to the problem you will be talking about.') 
     AND option_text = 'You cleverly refer to the previous presentation and show the advantages of your approach.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'self-confidence -' LIMIT 1), 3);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = '3. Flexibility' AND owner_id = (SELECT id FROM simulator WHERE title = 'Public Speaking') LIMIT 1), 'mcq', 2, LAST_INSERT_ID());

-- ============================================
-- Feedback Tiers
-- ============================================

-- Feedback for metric 'assertiveness' (Score 0-100)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Public Speaking'), (SELECT id FROM simulator_metric WHERE name = 'assertiveness' LIMIT 1), 0, 100, 'You probably give the impression of someone who can put up with a lot and usually agrees to other people''s suggestions.', 'Some people may take advantage of your sensitivity.', 'Practice setting boundaries. Always give yourself time to reflect before saying yes or no to someone.', NULL, NULL);

-- Feedback for metric 'assertiveness' (Score 0-100)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Public Speaking'), (SELECT id FROM simulator_metric WHERE name = 'assertiveness' LIMIT 1), 0, 100, 'You probably can take care of yourself when necessary.', 'It is worth reinforcing the message with body language and tone of voice.', 'Pay attention to your body language. Practice an open posture.', NULL, NULL);

-- Feedback for metric 'assertiveness' (Score 0-100)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Public Speaking'), (SELECT id FROM simulator_metric WHERE name = 'assertiveness' LIMIT 1), 0, 100, 'You probably have the ability to set boundaries for others.', 'Sometimes it is worth taking care of the diplomatic form of communication.', 'Practice diplomacy, assertiveness is an important quality of a leader.', NULL, NULL);

-- Feedback for metric 'composure' (Score 0-100)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Public Speaking'), (SELECT id FROM simulator_metric WHERE name = 'composure' LIMIT 1), 0, 100, 'It''s possible that you take your tasks very seriously and care about results.', 'Sometimes it''s hard to control your nerves when you really care about something.', 'Do breathing and relaxation exercises before public events.', NULL, NULL);

-- Feedback for metric 'composure' (Score 0-100)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Public Speaking'), (SELECT id FROM simulator_metric WHERE name = 'composure' LIMIT 1), 0, 100, 'You probably handle stress pretty well if you don''t have any surprises.', 'In difficult situations, you may need to decompress.', 'Give yourself permission to take a break. When you feel stress rising, slow down a bit.', NULL, NULL);

-- Feedback for metric 'composure' (Score 0-100)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Public Speaking'), (SELECT id FROM simulator_metric WHERE name = 'composure' LIMIT 1), 0, 100, 'You are probably composed and give the impression of a professional.', 'It is worth taking care to relieve tension in a safe space.', 'After public speaking, take care of your body, go for a walk, relax.', NULL, NULL);

-- Feedback for metric 'self-confidence' (Score 0-100)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Public Speaking'), (SELECT id FROM simulator_metric WHERE name = 'self-confidence' LIMIT 1), 0, 100, 'You may be the kind of person who prepares very carefully and checks many times to make sure everything is okay.', 'You may be worried about what others will think of you.', 'Before each public event, write down at least three things you are proud of.', NULL, NULL);

-- Feedback for metric 'self-confidence' (Score 0-100)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Public Speaking'), (SELECT id FROM simulator_metric WHERE name = 'self-confidence' LIMIT 1), 0, 100, 'Perhaps you are capable of more than you think.', 'Sometimes it''s worth openly admitting that you''re doing great.', 'When people give you positive feedback, be happy and admit they''re right.', NULL, NULL);

-- Feedback for metric 'self-confidence' (Score 0-100)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Public Speaking'), (SELECT id FROM simulator_metric WHERE name = 'self-confidence' LIMIT 1), 0, 100, 'You probably know what you want and usually feel that what you are doing is ok.', 'Sometimes it''s worth asking for feedback and taking the opinions of others into account.', 'Practice analyzing situations from different perspectives. Other people may have inspiring insights.', NULL, NULL);

-- ============================================
-- End of generated queries
-- ============================================
