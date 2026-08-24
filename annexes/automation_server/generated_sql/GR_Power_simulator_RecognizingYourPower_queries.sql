-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:10.775966
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Simulator: Recognizing Your Power
-- ============================================
INSERT INTO simulator (title, description, level, localisation, estimated_duration, created_at) VALUES ('Recognizing Your Power', 'No description', 'intro', 'Work', 10, '2026-08-23 19:54:10.775195');

-- Simulator Tags
INSERT INTO simulator_tag (name) VALUES ('Self-awareness');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'Recognizing Your Power'), (SELECT id FROM simulator_tag WHERE name = 'Self-awareness' LIMIT 1));
INSERT INTO simulator_tag (name) VALUES ('Confidence');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'Recognizing Your Power'), (SELECT id FROM simulator_tag WHERE name = 'Confidence' LIMIT 1));
INSERT INTO simulator_tag (name) VALUES ('Leadership Identity');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'Recognizing Your Power'), (SELECT id FROM simulator_tag WHERE name = 'Leadership Identity' LIMIT 1));
INSERT INTO simulator_tag (name) VALUES ('Personal Development');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'Recognizing Your Power'), (SELECT id FROM simulator_tag WHERE name = 'Personal Development' LIMIT 1));
INSERT INTO simulator_tag (name) VALUES ('Women’s Leadership');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'Recognizing Your Power'), (SELECT id FROM simulator_tag WHERE name = 'Women’s Leadership' LIMIT 1));

-- Simulator Metrics
INSERT INTO simulator_metric (name) VALUES ('Self-awareness');
INSERT INTO simulator_contains_metric (simulator_id, metric_id) VALUES ((SELECT id FROM simulator WHERE title = 'Recognizing Your Power'), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1));
INSERT INTO simulator_metric (name) VALUES ('Confidence');
INSERT INTO simulator_contains_metric (simulator_id, metric_id) VALUES ((SELECT id FROM simulator WHERE title = 'Recognizing Your Power'), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1));
INSERT INTO simulator_metric (name) VALUES ('Visibility');
INSERT INTO simulator_contains_metric (simulator_id, metric_id) VALUES ((SELECT id FROM simulator WHERE title = 'Recognizing Your Power'), (SELECT id FROM simulator_metric WHERE name = 'Visibility' LIMIT 1));

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'Recognizing Your Power'), 1, 'Phase 1: Pause and Notice', 'Before the meeting', 'Your preparation shapes how you enter the room. Even a small pause can help you recognise that your perspective has value.', 'This question helps one notice the moment before action. Recognising power often starts with identifying the thought patterns that make women minimise their contribution before anyone else does.');

-- Component 1 for Card 0
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1obZie-QSS_UGjcwBrGqOyE3yv2g99bQ1/view?usp=drive_link', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 1: Pause and Notice' AND owner_id = (SELECT id FROM simulator WHERE title = 'Recognizing Your Power') LIMIT 1), 'image', 1, LAST_INSERT_ID());

-- Component 2 for Card 0
INSERT INTO component_text (content) VALUES ('You are about to join a team meeting. A new project will be discussed, and you have already noticed one important issue that others may have missed. You know your perspective could help, but you are not sure whether it is “your place” to speak.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 1: Pause and Notice' AND owner_id = (SELECT id FROM simulator WHERE title = 'Recognizing Your Power') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 0
INSERT INTO component_mcq (question) VALUES ('You are about to join a team meeting. A new project will be discussed, and you have already noticed one important issue that others may have missed. You know your perspective could help, but you are not sure whether it is “your place” to speak.');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You are about to join a team meeting. A new project will be discussed, and you have already noticed one important issue that others may have missed. You know your perspective could help, but you are not sure whether it is “your place” to speak.' ORDER BY id DESC LIMIT 1), 'You tell yourself: “I probably don’t know enough yet,” and decide to wait silently.', 'This protects you from possible discomfort, but it also hides a useful perspective. Waiting can be wise, but automatic silence can become a habit.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You are about to join a team meeting. A new project will be discussed, and you have already noticed one important issue that others may have missed. You know your perspective could help, but you are not sure whether it is “your place” to speak.') 
     AND option_text = 'You tell yourself: “I probably don’t know enough yet,” and decide to wait silently.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), -10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You are about to join a team meeting. A new project will be discussed, and you have already noticed one important issue that others may have missed. You know your perspective could help, but you are not sure whether it is “your place” to speak.') 
     AND option_text = 'You tell yourself: “I probably don’t know enough yet,” and decide to wait silently.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), -10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You are about to join a team meeting. A new project will be discussed, and you have already noticed one important issue that others may have missed. You know your perspective could help, but you are not sure whether it is “your place” to speak.') 
     AND option_text = 'You tell yourself: “I probably don’t know enough yet,” and decide to wait silently.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Visibility' LIMIT 1), -10);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You are about to join a team meeting. A new project will be discussed, and you have already noticed one important issue that others may have missed. You know your perspective could help, but you are not sure whether it is “your place” to speak.' ORDER BY id DESC LIMIT 1), 'You quickly write down your point and one reason why it matters before the meeting starts.', 'Good choice. You are not forcing yourself to perform confidence. You are creating a small structure that helps you recognise the value of your contribution.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You are about to join a team meeting. A new project will be discussed, and you have already noticed one important issue that others may have missed. You know your perspective could help, but you are not sure whether it is “your place” to speak.') 
     AND option_text = 'You quickly write down your point and one reason why it matters before the meeting starts.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You are about to join a team meeting. A new project will be discussed, and you have already noticed one important issue that others may have missed. You know your perspective could help, but you are not sure whether it is “your place” to speak.') 
     AND option_text = 'You quickly write down your point and one reason why it matters before the meeting starts.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), 10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You are about to join a team meeting. A new project will be discussed, and you have already noticed one important issue that others may have missed. You know your perspective could help, but you are not sure whether it is “your place” to speak.') 
     AND option_text = 'You quickly write down your point and one reason why it matters before the meeting starts.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Visibility' LIMIT 1), 5);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You are about to join a team meeting. A new project will be discussed, and you have already noticed one important issue that others may have missed. You know your perspective could help, but you are not sure whether it is “your place” to speak.' ORDER BY id DESC LIMIT 1), 'You decide that you must prove yourself strongly in the meeting, no matter what.', 'The intention is understandable, but pressure to “prove yourself” can increase stress. Power grows more sustainably when it is grounded in clarity, not self-pressure.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You are about to join a team meeting. A new project will be discussed, and you have already noticed one important issue that others may have missed. You know your perspective could help, but you are not sure whether it is “your place” to speak.') 
     AND option_text = 'You decide that you must prove yourself strongly in the meeting, no matter what.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), -5);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You are about to join a team meeting. A new project will be discussed, and you have already noticed one important issue that others may have missed. You know your perspective could help, but you are not sure whether it is “your place” to speak.') 
     AND option_text = 'You decide that you must prove yourself strongly in the meeting, no matter what.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), 5);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You are about to join a team meeting. A new project will be discussed, and you have already noticed one important issue that others may have missed. You know your perspective could help, but you are not sure whether it is “your place” to speak.') 
     AND option_text = 'You decide that you must prove yourself strongly in the meeting, no matter what.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Visibility' LIMIT 1), 10);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 1: Pause and Notice' AND owner_id = (SELECT id FROM simulator WHERE title = 'Recognizing Your Power') LIMIT 1), 'mcq', 3, LAST_INSERT_ID());

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'Recognizing Your Power'), 2, 'Phase 2: The Idea', 'Recognising your contribution', 'Speaking up does not have to be dramatic. Sometimes power sounds like one clear sentence at the right moment.', 'This question focuses on visibility. The learner practises moving from “I have an idea” to “I can express this idea clearly and professionally.”');

-- Component 1 for Card 1
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1sSFyqXhk9gd9E6QttkvPJ6qjW9XrQ87B/view?usp=drive_link', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 2: The Idea' AND owner_id = (SELECT id FROM simulator WHERE title = 'Recognizing Your Power') LIMIT 1), 'image', 1, LAST_INSERT_ID());

-- Component 2 for Card 1
INSERT INTO component_text (content) VALUES ('During the meeting, the team discusses the project timeline. You realise that one group of users has not been considered, and this could affect the quality of the final result. The discussion is moving quickly.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 2: The Idea' AND owner_id = (SELECT id FROM simulator WHERE title = 'Recognizing Your Power') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 1
INSERT INTO component_mcq (question) VALUES ('During the meeting, the team discusses the project timeline. You realise that one group of users has not been considered, and this could affect the quality of the final result. The discussion is moving quickly.');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'During the meeting, the team discusses the project timeline. You realise that one group of users has not been considered, and this could affect the quality of the final result. The discussion is moving quickly.' ORDER BY id DESC LIMIT 1), 'You say: “Sorry, maybe this is not important, but…” and then share your concern.', 'You did speak, which matters. However, starting with an apology may weaken the message before others have even heard it.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'During the meeting, the team discusses the project timeline. You realise that one group of users has not been considered, and this could affect the quality of the final result. The discussion is moving quickly.') 
     AND option_text = 'You say: “Sorry, maybe this is not important, but…” and then share your concern.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), 5);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'During the meeting, the team discusses the project timeline. You realise that one group of users has not been considered, and this could affect the quality of the final result. The discussion is moving quickly.') 
     AND option_text = 'You say: “Sorry, maybe this is not important, but…” and then share your concern.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), -5);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'During the meeting, the team discusses the project timeline. You realise that one group of users has not been considered, and this could affect the quality of the final result. The discussion is moving quickly.') 
     AND option_text = 'You say: “Sorry, maybe this is not important, but…” and then share your concern.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Visibility' LIMIT 1), 10);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'During the meeting, the team discusses the project timeline. You realise that one group of users has not been considered, and this could affect the quality of the final result. The discussion is moving quickly.' ORDER BY id DESC LIMIT 1), 'You say: “I’d like to add one point about users we may not have considered yet.”', 'Strong choice. You communicate clearly, without over-apologising or over-explaining. You make space for your perspective while keeping the discussion focused.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'During the meeting, the team discusses the project timeline. You realise that one group of users has not been considered, and this could affect the quality of the final result. The discussion is moving quickly.') 
     AND option_text = 'You say: “I’d like to add one point about users we may not have considered yet.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), 10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'During the meeting, the team discusses the project timeline. You realise that one group of users has not been considered, and this could affect the quality of the final result. The discussion is moving quickly.') 
     AND option_text = 'You say: “I’d like to add one point about users we may not have considered yet.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'During the meeting, the team discusses the project timeline. You realise that one group of users has not been considered, and this could affect the quality of the final result. The discussion is moving quickly.') 
     AND option_text = 'You say: “I’d like to add one point about users we may not have considered yet.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Visibility' LIMIT 1), 15);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'During the meeting, the team discusses the project timeline. You realise that one group of users has not been considered, and this could affect the quality of the final result. The discussion is moving quickly.' ORDER BY id DESC LIMIT 1), 'You keep the idea to yourself and decide to mention it only if someone asks.', 'This may feel safer, but it makes your contribution dependent on others inviting you in. Leadership often means offering relevant input before being asked.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'During the meeting, the team discusses the project timeline. You realise that one group of users has not been considered, and this could affect the quality of the final result. The discussion is moving quickly.') 
     AND option_text = 'You keep the idea to yourself and decide to mention it only if someone asks.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), -5);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'During the meeting, the team discusses the project timeline. You realise that one group of users has not been considered, and this could affect the quality of the final result. The discussion is moving quickly.') 
     AND option_text = 'You keep the idea to yourself and decide to mention it only if someone asks.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), -10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'During the meeting, the team discusses the project timeline. You realise that one group of users has not been considered, and this could affect the quality of the final result. The discussion is moving quickly.') 
     AND option_text = 'You keep the idea to yourself and decide to mention it only if someone asks.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Visibility' LIMIT 1), -15);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 2: The Idea' AND owner_id = (SELECT id FROM simulator WHERE title = 'Recognizing Your Power') LIMIT 1), 'mcq', 3, LAST_INSERT_ID());

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'Recognizing Your Power'), 3, 'Phase 3: The Reaction', 'Staying connected to your value', 'A dismissive response does not automatically mean your point is wrong. You can stay grounded, clarify the value of your contribution, and keep the conversation useful.', 'This question explores how one respond when their contribution is challenged or minimised. It supports confidence that remains calm and connected to purpose.');

-- Component 1 for Card 2
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1lcrEw3oW3-TKVSYW9IMAk59c4_Oof5QJ/view?usp=drive_link', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 3: The Reaction' AND owner_id = (SELECT id FROM simulator WHERE title = 'Recognizing Your Power') LIMIT 1), 'image', 1, LAST_INSERT_ID());

-- Component 2 for Card 2
INSERT INTO component_text (content) VALUES ('After you share your point, someone replies: “That may be too much detail for now. We can come back to it later.” You feel your confidence drop a little. You still believe the issue matters.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 3: The Reaction' AND owner_id = (SELECT id FROM simulator WHERE title = 'Recognizing Your Power') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 2
INSERT INTO component_mcq (question) VALUES ('After you share your point, someone replies: “That may be too much detail for now. We can come back to it later.” You feel your confidence drop a little. You still believe the issue matters.');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'After you share your point, someone replies: “That may be too much detail for now. We can come back to it later.” You feel your confidence drop a little. You still believe the issue matters.' ORDER BY id DESC LIMIT 1), 'You respond calmly: “I understand. I think it affects the timeline, so I suggest we note it now and decide when to address it.”', 'Excellent. You stay constructive without becoming defensive. You connect your point to the team’s goal and keep it visible.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'After you share your point, someone replies: “That may be too much detail for now. We can come back to it later.” You feel your confidence drop a little. You still believe the issue matters.') 
     AND option_text = 'You respond calmly: “I understand. I think it affects the timeline, so I suggest we note it now and decide when to address it.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'After you share your point, someone replies: “That may be too much detail for now. We can come back to it later.” You feel your confidence drop a little. You still believe the issue matters.') 
     AND option_text = 'You respond calmly: “I understand. I think it affects the timeline, so I suggest we note it now and decide when to address it.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'After you share your point, someone replies: “That may be too much detail for now. We can come back to it later.” You feel your confidence drop a little. You still believe the issue matters.') 
     AND option_text = 'You respond calmly: “I understand. I think it affects the timeline, so I suggest we note it now and decide when to address it.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Visibility' LIMIT 1), 10);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'After you share your point, someone replies: “That may be too much detail for now. We can come back to it later.” You feel your confidence drop a little. You still believe the issue matters.' ORDER BY id DESC LIMIT 1), 'You withdraw and say: “Yes, you’re right, it’s probably not relevant now.”', 'This avoids tension, but it may also reinforce the idea that your contribution was less important than it was. Notice whether you are agreeing or retreating.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'After you share your point, someone replies: “That may be too much detail for now. We can come back to it later.” You feel your confidence drop a little. You still believe the issue matters.') 
     AND option_text = 'You withdraw and say: “Yes, you’re right, it’s probably not relevant now.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), -5);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'After you share your point, someone replies: “That may be too much detail for now. We can come back to it later.” You feel your confidence drop a little. You still believe the issue matters.') 
     AND option_text = 'You withdraw and say: “Yes, you’re right, it’s probably not relevant now.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), -15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'After you share your point, someone replies: “That may be too much detail for now. We can come back to it later.” You feel your confidence drop a little. You still believe the issue matters.') 
     AND option_text = 'You withdraw and say: “Yes, you’re right, it’s probably not relevant now.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Visibility' LIMIT 1), -10);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'After you share your point, someone replies: “That may be too much detail for now. We can come back to it later.” You feel your confidence drop a little. You still believe the issue matters.' ORDER BY id DESC LIMIT 1), 'You push back sharply: “No, this is exactly the problem — people never listen.”', 'Your frustration may be valid, but the way it is expressed may make others focus on the tone instead of the issue. Power is not the same as escalation.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'After you share your point, someone replies: “That may be too much detail for now. We can come back to it later.” You feel your confidence drop a little. You still believe the issue matters.') 
     AND option_text = 'You push back sharply: “No, this is exactly the problem — people never listen.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), -10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'After you share your point, someone replies: “That may be too much detail for now. We can come back to it later.” You feel your confidence drop a little. You still believe the issue matters.') 
     AND option_text = 'You push back sharply: “No, this is exactly the problem — people never listen.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), 5);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'After you share your point, someone replies: “That may be too much detail for now. We can come back to it later.” You feel your confidence drop a little. You still believe the issue matters.') 
     AND option_text = 'You push back sharply: “No, this is exactly the problem — people never listen.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Visibility' LIMIT 1), 5);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 3: The Reaction' AND owner_id = (SELECT id FROM simulator WHERE title = 'Recognizing Your Power') LIMIT 1), 'mcq', 3, LAST_INSERT_ID());

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'Recognizing Your Power'), 4, 'Phase 4: Naming Your Strength', 'Seeing leadership in action', 'Leadership identity grows when you notice what you did, what value it created, and how it affected others.', 'This question helps integrate feedback. Recognising power includes learning to accept evidence of competence instead of immediately minimising it.');

-- Component 1 for Card 3
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1Fc3qRpgBC8oFeBqWGIjbDcmmBmRTRObK/view?usp=drive_link', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 4: Naming Your Strength' AND owner_id = (SELECT id FROM simulator WHERE title = 'Recognizing Your Power') LIMIT 1), 'image', 1, LAST_INSERT_ID());

-- Component 2 for Card 3
INSERT INTO component_text (content) VALUES ('Later that day, a colleague tells you privately: “I’m glad you mentioned that. I was thinking the same thing but didn’t say it.” You realise your action may have helped others too.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 4: Naming Your Strength' AND owner_id = (SELECT id FROM simulator WHERE title = 'Recognizing Your Power') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 3
INSERT INTO component_mcq (question) VALUES ('Later that day, a colleague tells you privately: “I’m glad you mentioned that. I was thinking the same thing but didn’t say it.” You realise your action may have helped others too.');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Later that day, a colleague tells you privately: “I’m glad you mentioned that. I was thinking the same thing but didn’t say it.” You realise your action may have helped others too.' ORDER BY id DESC LIMIT 1), 'You say: “Next time, you should say it instead of leaving it to me.”', 'This may be partly fair, but it misses the chance to recognise your own action. It could also close down connection with someone who trusted you.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Later that day, a colleague tells you privately: “I’m glad you mentioned that. I was thinking the same thing but didn’t say it.” You realise your action may have helped others too.') 
     AND option_text = 'You say: “Next time, you should say it instead of leaving it to me.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), -5);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Later that day, a colleague tells you privately: “I’m glad you mentioned that. I was thinking the same thing but didn’t say it.” You realise your action may have helped others too.') 
     AND option_text = 'You say: “Next time, you should say it instead of leaving it to me.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), 5);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Later that day, a colleague tells you privately: “I’m glad you mentioned that. I was thinking the same thing but didn’t say it.” You realise your action may have helped others too.') 
     AND option_text = 'You say: “Next time, you should say it instead of leaving it to me.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Visibility' LIMIT 1), 0);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Later that day, a colleague tells you privately: “I’m glad you mentioned that. I was thinking the same thing but didn’t say it.” You realise your action may have helped others too.' ORDER BY id DESC LIMIT 1), 'You reply: “Really? I thought I was just being annoying.”', 'This is honest, but it shows how easily useful leadership can be misread as “being too much.” Try not to dismiss evidence of your own impact.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Later that day, a colleague tells you privately: “I’m glad you mentioned that. I was thinking the same thing but didn’t say it.” You realise your action may have helped others too.') 
     AND option_text = 'You reply: “Really? I thought I was just being annoying.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), -5);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Later that day, a colleague tells you privately: “I’m glad you mentioned that. I was thinking the same thing but didn’t say it.” You realise your action may have helped others too.') 
     AND option_text = 'You reply: “Really? I thought I was just being annoying.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), -10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Later that day, a colleague tells you privately: “I’m glad you mentioned that. I was thinking the same thing but didn’t say it.” You realise your action may have helped others too.') 
     AND option_text = 'You reply: “Really? I thought I was just being annoying.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Visibility' LIMIT 1), -5);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Later that day, a colleague tells you privately: “I’m glad you mentioned that. I was thinking the same thing but didn’t say it.” You realise your action may have helped others too.' ORDER BY id DESC LIMIT 1), 'You say: “Thank you. I’m glad it helped. I’m trying to speak up when I notice something important.”', 'Very strong. You accept positive feedback and name the behaviour. This helps you build a more accurate picture of your leadership identity.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Later that day, a colleague tells you privately: “I’m glad you mentioned that. I was thinking the same thing but didn’t say it.” You realise your action may have helped others too.') 
     AND option_text = 'You say: “Thank you. I’m glad it helped. I’m trying to speak up when I notice something important.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Later that day, a colleague tells you privately: “I’m glad you mentioned that. I was thinking the same thing but didn’t say it.” You realise your action may have helped others too.') 
     AND option_text = 'You say: “Thank you. I’m glad it helped. I’m trying to speak up when I notice something important.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Later that day, a colleague tells you privately: “I’m glad you mentioned that. I was thinking the same thing but didn’t say it.” You realise your action may have helped others too.') 
     AND option_text = 'You say: “Thank you. I’m glad it helped. I’m trying to speak up when I notice something important.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Visibility' LIMIT 1), 10);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 4: Naming Your Strength' AND owner_id = (SELECT id FROM simulator WHERE title = 'Recognizing Your Power') LIMIT 1), 'mcq', 3, LAST_INSERT_ID());

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'Recognizing Your Power'), 5, 'Phase 5: Reflection', 'Power already exists', 'You have completed the simulator. Your result reflects how you currently recognise and use your power in everyday leadership moments. Use the feedback as a starting point, not as a label.', 'This final question consolidates learning. The learner is invited to define leadership through concrete behaviour rather than status, perfection, or external validation.');

-- Component 1 for Card 4
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1rHNi4rNXen3V3eAZKrAue3eaKfx6bVBV/view?usp=sharing', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 5: Reflection' AND owner_id = (SELECT id FROM simulator WHERE title = 'Recognizing Your Power') LIMIT 1), 'image', 1, LAST_INSERT_ID());

-- Component 2 for Card 4
INSERT INTO component_text (content) VALUES ('You have reached the end of the situation. Take a moment to reflect: leadership did not begin when someone gave you permission to speak. It began when you noticed something important, trusted your perspective, and chose to contribute.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 5: Reflection' AND owner_id = (SELECT id FROM simulator WHERE title = 'Recognizing Your Power') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 4
INSERT INTO component_mcq (question) VALUES ('You have reached the end of the situation. Take a moment to reflect: leadership did not begin when someone gave you permission to speak. It began when you noticed something important, trusted your perspective, and chose to contribute.');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You have reached the end of the situation. Take a moment to reflect: leadership did not begin when someone gave you permission to speak. It began when you noticed something important, trusted your perspective, and chose to contribute.' ORDER BY id DESC LIMIT 1), 'You write: “Today I spoke up because I noticed something that mattered.”', 'Excellent reflection. You connect your action with purpose, which strengthens self-awareness and confidence.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You have reached the end of the situation. Take a moment to reflect: leadership did not begin when someone gave you permission to speak. It began when you noticed something important, trusted your perspective, and chose to contribute.') 
     AND option_text = 'You write: “Today I spoke up because I noticed something that mattered.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You have reached the end of the situation. Take a moment to reflect: leadership did not begin when someone gave you permission to speak. It began when you noticed something important, trusted your perspective, and chose to contribute.') 
     AND option_text = 'You write: “Today I spoke up because I noticed something that mattered.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), 10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You have reached the end of the situation. Take a moment to reflect: leadership did not begin when someone gave you permission to speak. It began when you noticed something important, trusted your perspective, and chose to contribute.') 
     AND option_text = 'You write: “Today I spoke up because I noticed something that mattered.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Visibility' LIMIT 1), 5);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You have reached the end of the situation. Take a moment to reflect: leadership did not begin when someone gave you permission to speak. It began when you noticed something important, trusted your perspective, and chose to contribute.' ORDER BY id DESC LIMIT 1), 'You write: “I need to become much more confident before I can lead.”', 'This is a common belief, but it can delay action. Confidence often grows through small acts of leadership, not before them.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You have reached the end of the situation. Take a moment to reflect: leadership did not begin when someone gave you permission to speak. It began when you noticed something important, trusted your perspective, and chose to contribute.') 
     AND option_text = 'You write: “I need to become much more confident before I can lead.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), -5);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You have reached the end of the situation. Take a moment to reflect: leadership did not begin when someone gave you permission to speak. It began when you noticed something important, trusted your perspective, and chose to contribute.') 
     AND option_text = 'You write: “I need to become much more confident before I can lead.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), -10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You have reached the end of the situation. Take a moment to reflect: leadership did not begin when someone gave you permission to speak. It began when you noticed something important, trusted your perspective, and chose to contribute.') 
     AND option_text = 'You write: “I need to become much more confident before I can lead.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Visibility' LIMIT 1), -5);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You have reached the end of the situation. Take a moment to reflect: leadership did not begin when someone gave you permission to speak. It began when you noticed something important, trusted your perspective, and chose to contribute.' ORDER BY id DESC LIMIT 1), 'You write: “Maybe leadership can also mean noticing, caring, and contributing.”', 'Very strong. This expands leadership beyond titles and formal authority. It helps you recognise power in everyday behaviours.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You have reached the end of the situation. Take a moment to reflect: leadership did not begin when someone gave you permission to speak. It began when you noticed something important, trusted your perspective, and chose to contribute.') 
     AND option_text = 'You write: “Maybe leadership can also mean noticing, caring, and contributing.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You have reached the end of the situation. Take a moment to reflect: leadership did not begin when someone gave you permission to speak. It began when you noticed something important, trusted your perspective, and chose to contribute.') 
     AND option_text = 'You write: “Maybe leadership can also mean noticing, caring, and contributing.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), 10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You have reached the end of the situation. Take a moment to reflect: leadership did not begin when someone gave you permission to speak. It began when you noticed something important, trusted your perspective, and chose to contribute.') 
     AND option_text = 'You write: “Maybe leadership can also mean noticing, caring, and contributing.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Visibility' LIMIT 1), 10);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 5: Reflection' AND owner_id = (SELECT id FROM simulator WHERE title = 'Recognizing Your Power') LIMIT 1), 'mcq', 3, LAST_INSERT_ID());

-- ============================================
-- Feedback Tiers
-- ============================================

-- Feedback for metric 'Self-awareness' (Score 0-49)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Recognizing Your Power'), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), 0, 49, 'You are beginning to notice your thoughts, strengths, and reactions.', 'You may underestimate your contribution or move through situations without fully recognising what you bring.', 'At the end of each day, write one sentence: “Today I contributed by…”', NULL, 'This module can help you explore your values, strengths, and leadership identity with more clarity.');

-- Feedback for metric 'Self-awareness' (Score 50-85)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Recognizing Your Power'), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), 50, 85, 'You are becoming more aware of your patterns and strengths.', 'You may still minimise your contribution, especially in situations where you feel observed or judged.', 'After a meeting, write down one thing you noticed, one thing you felt, and one thing you contributed.', NULL, 'This module can support you in connecting self-awareness with confidence and personal growth.');

-- Feedback for metric 'Self-awareness' (Score 85-100)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Recognizing Your Power'), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), 85, 100, 'You recognise your strengths, reactions, and contribution with clarity.', 'None. You already have a strong foundation for intentional leadership.', 'Once a week, identify one strength you used and one situation where you want to use it more consciously.', NULL, 'This module can help you move from self-awareness to visible, intentional leadership action.');

-- Feedback for metric 'Confidence' (Score 0-49)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Recognizing Your Power'), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), 0, 49, 'You are starting to build trust in your voice.', 'You may wait for certainty or permission before contributing, even when your perspective is useful.', 'Prepare one clear sentence before a meeting: “I would like to add…” or “One point to consider is…”', NULL, 'This module can help you strengthen self-belief and take small, realistic steps toward confidence.');

-- Feedback for metric 'Confidence' (Score 50-85)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Recognizing Your Power'), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), 50, 85, 'You can express yourself, especially when you feel prepared.', 'You may still apologise, soften, or over-explain when sharing your ideas.', 'Replace one apologetic opening with a clear one: “I’d like to add a point.”', NULL, 'This module can help you practise confidence as a leadership behaviour, not only as an internal feeling.');

-- Feedback for metric 'Confidence' (Score 85-100)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Recognizing Your Power'), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), 85, 100, 'You trust your voice and can contribute even when the situation is not perfect.', 'None. You are ready to keep strengthening confidence through practice and responsibility.', 'Before important conversations, remind yourself: “My role is to contribute, not to be perfect.”', NULL, 'This module can help you use confidence to support decisions, communication, and influence.');

-- Feedback for metric 'Visibility' (Score 0-49)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Recognizing Your Power'), (SELECT id FROM simulator_metric WHERE name = 'Visibility' LIMIT 1), 0, 49, 'You have useful ideas, but you may not always allow others to see them.', 'Your work, insight, or leadership potential may remain unnoticed if you stay too much in the background.', 'In your next group discussion, contribute one observation or question early.', NULL, 'This module can help you understand visibility as part of influence and leadership presence.');

-- Feedback for metric 'Visibility' (Score 50-85)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Recognizing Your Power'), (SELECT id FROM simulator_metric WHERE name = 'Visibility' LIMIT 1), 50, 85, 'You are becoming more visible and are learning when to step forward.', 'You may still become less visible when challenged, interrupted, or unsure.', 'Practise linking your contribution to the shared goal: “I mention this because it affects…”', NULL, 'This module can help you strengthen your presence while staying authentic and purposeful.');

-- Feedback for metric 'Visibility' (Score 85-100)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Recognizing Your Power'), (SELECT id FROM simulator_metric WHERE name = 'Visibility' LIMIT 1), 85, 100, 'You are able to make your contribution visible in a clear and constructive way.', 'None. You already show strong potential for visible and authentic leadership.', 'Notice one situation each week where your visibility helped the group move forward.', NULL, 'This module can help you deepen your influence and support others to become visible too.');

-- ============================================
-- End of generated queries
-- ============================================
