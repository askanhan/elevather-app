-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:10.534232
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Simulator: The opportunity you didn't expect
-- ============================================
INSERT INTO simulator (title, description, level, localisation, estimated_duration, created_at) VALUES ('The opportunity you didn''t expect', 'No description', 'core', 'Work, community', 8, '2026-08-23 19:54:10.533310');

-- Simulator Tags
INSERT INTO simulator_tag (name) VALUES ('Confidence');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'The opportunity you didn''t expect'), (SELECT id FROM simulator_tag WHERE name = 'Confidence' LIMIT 1));
INSERT INTO simulator_tag (name) VALUES ('Inner potential');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'The opportunity you didn''t expect'), (SELECT id FROM simulator_tag WHERE name = 'Inner potential' LIMIT 1));
INSERT INTO simulator_tag (name) VALUES ('Self-beliefs');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'The opportunity you didn''t expect'), (SELECT id FROM simulator_tag WHERE name = 'Self-beliefs' LIMIT 1));

-- Simulator Metrics
INSERT INTO simulator_metric (name) VALUES ('Sefl-awarness');
INSERT INTO simulator_contains_metric (simulator_id, metric_id) VALUES ((SELECT id FROM simulator WHERE title = 'The opportunity you didn''t expect'), (SELECT id FROM simulator_metric WHERE name = 'Sefl-awarness' LIMIT 1));
INSERT INTO simulator_metric (name) VALUES ('Confidence');
INSERT INTO simulator_contains_metric (simulator_id, metric_id) VALUES ((SELECT id FROM simulator WHERE title = 'The opportunity you didn''t expect'), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1));
INSERT INTO simulator_metric (name) VALUES ('Potential exploration');
INSERT INTO simulator_contains_metric (simulator_id, metric_id) VALUES ((SELECT id FROM simulator WHERE title = 'The opportunity you didn''t expect'), (SELECT id FROM simulator_metric WHERE name = 'Potential exploration' LIMIT 1));

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'The opportunity you didn''t expect'), 1, 'Phase 1: The invitation', 'An unexpected opportunity', NULL, 'Many opportunities are accepted or rejected within seconds. This question explores your automatic beliefs about yourself when facing something new.');

-- Component 1 for Card 0
INSERT INTO component_text (content) VALUES ('You receive an email inviting you to join a high-visibility project. The topic interests you, but you have never done anything quite like this before. The project would give you a chance to learn, contribute, and work with new people. What is your first reaction?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 1: The invitation' AND owner_id = (SELECT id FROM simulator WHERE title = 'The opportunity you didn''t expect') LIMIT 1), 'text', 1, LAST_INSERT_ID());

-- Component 2 for Card 0
INSERT INTO component_mcq (question) VALUES ('You receive an email inviting you to join a high-visibility project. The topic interests you, but you have never done anything quite like this before. The project would give you a chance to learn, contribute, and work with new people. What is your first reaction?');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You receive an email inviting you to join a high-visibility project. The topic interests you, but you have never done anything quite like this before. The project would give you a chance to learn, contribute, and work with new people. What is your first reaction?' ORDER BY id DESC LIMIT 1), 'I''m not sure I''m qualified enough. There are probably better candidates.', 'This reaction is common, especially when facing something new. It may reflect caution, but it can also be a sign that you underestimate your existing strengths');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You receive an email inviting you to join a high-visibility project. The topic interests you, but you have never done anything quite like this before. The project would give you a chance to learn, contribute, and work with new people. What is your first reaction?') 
     AND option_text = 'I''m not sure I''m qualified enough. There are probably better candidates.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), 5);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You receive an email inviting you to join a high-visibility project. The topic interests you, but you have never done anything quite like this before. The project would give you a chance to learn, contribute, and work with new people. What is your first reaction?') 
     AND option_text = 'I''m not sure I''m qualified enough. There are probably better candidates.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), 0);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You receive an email inviting you to join a high-visibility project. The topic interests you, but you have never done anything quite like this before. The project would give you a chance to learn, contribute, and work with new people. What is your first reaction?') 
     AND option_text = 'I''m not sure I''m qualified enough. There are probably better candidates.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Potential Exploration' LIMIT 1), 0);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You receive an email inviting you to join a high-visibility project. The topic interests you, but you have never done anything quite like this before. The project would give you a chance to learn, contribute, and work with new people. What is your first reaction?' ORDER BY id DESC LIMIT 1), 'This sounds interesting. I''d like to learn more before deciding.', 'Strong choice. You balance curiosity with reflection. Exploring an opportunity does not mean committing to it.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You receive an email inviting you to join a high-visibility project. The topic interests you, but you have never done anything quite like this before. The project would give you a chance to learn, contribute, and work with new people. What is your first reaction?') 
     AND option_text = 'This sounds interesting. I''d like to learn more before deciding.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You receive an email inviting you to join a high-visibility project. The topic interests you, but you have never done anything quite like this before. The project would give you a chance to learn, contribute, and work with new people. What is your first reaction?') 
     AND option_text = 'This sounds interesting. I''d like to learn more before deciding.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), 12);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You receive an email inviting you to join a high-visibility project. The topic interests you, but you have never done anything quite like this before. The project would give you a chance to learn, contribute, and work with new people. What is your first reaction?') 
     AND option_text = 'This sounds interesting. I''d like to learn more before deciding.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Potential Exploration' LIMIT 1), 15);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You receive an email inviting you to join a high-visibility project. The topic interests you, but you have never done anything quite like this before. The project would give you a chance to learn, contribute, and work with new people. What is your first reaction?' ORDER BY id DESC LIMIT 1), 'I''ve never done this before - that''s exactly why it could be worth trying.', 'You see unfamiliar situations as opportunities for growth. This mindset often helps people discover abilities they didn''t know they had.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You receive an email inviting you to join a high-visibility project. The topic interests you, but you have never done anything quite like this before. The project would give you a chance to learn, contribute, and work with new people. What is your first reaction?') 
     AND option_text = 'I''ve never done this before - that''s exactly why it could be worth trying.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), 12);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You receive an email inviting you to join a high-visibility project. The topic interests you, but you have never done anything quite like this before. The project would give you a chance to learn, contribute, and work with new people. What is your first reaction?') 
     AND option_text = 'I''ve never done this before - that''s exactly why it could be worth trying.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), 20);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You receive an email inviting you to join a high-visibility project. The topic interests you, but you have never done anything quite like this before. The project would give you a chance to learn, contribute, and work with new people. What is your first reaction?') 
     AND option_text = 'I''ve never done this before - that''s exactly why it could be worth trying.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Potential Exploration' LIMIT 1), 20);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 1: The invitation' AND owner_id = (SELECT id FROM simulator WHERE title = 'The opportunity you didn''t expect') LIMIT 1), 'mcq', 2, LAST_INSERT_ID());

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'The opportunity you didn''t expect'), 2, 'Phase 2: Looking for Clues', 'What do your experiences tell you?', NULL, 'Past experiences often contain clues about strengths we overlook. Looking at what made you proud can reveal hidden aspects of your potential.');

-- Component 1 for Card 1
INSERT INTO component_text (content) VALUES ('Before making a decision, you think about situations in which you felt proud of yourself. Which memory comes to mind first?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 2: Looking for Clues' AND owner_id = (SELECT id FROM simulator WHERE title = 'The opportunity you didn''t expect') LIMIT 1), 'text', 1, LAST_INSERT_ID());

-- Component 2 for Card 1
INSERT INTO component_mcq (question) VALUES ('Before making a decision, you think about situations in which you felt proud of yourself. Which memory comes to mind first?');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Before making a decision, you think about situations in which you felt proud of yourself. Which memory comes to mind first?' ORDER BY id DESC LIMIT 1), 'A moment when you helped someone overcome a challenge.', 'This may suggest that your strengths are connected to empathy, support, and understanding others.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Before making a decision, you think about situations in which you felt proud of yourself. Which memory comes to mind first?') 
     AND option_text = 'A moment when you helped someone overcome a challenge.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), 20);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Before making a decision, you think about situations in which you felt proud of yourself. Which memory comes to mind first?') 
     AND option_text = 'A moment when you helped someone overcome a challenge.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), 10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Before making a decision, you think about situations in which you felt proud of yourself. Which memory comes to mind first?') 
     AND option_text = 'A moment when you helped someone overcome a challenge.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Potential Exploration' LIMIT 1), 10);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Before making a decision, you think about situations in which you felt proud of yourself. Which memory comes to mind first?' ORDER BY id DESC LIMIT 1), 'A moment when you solved a difficult problem.', 'This may point to analytical thinking, persistence, and resourcefulness.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Before making a decision, you think about situations in which you felt proud of yourself. Which memory comes to mind first?') 
     AND option_text = 'A moment when you solved a difficult problem.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), 20);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Before making a decision, you think about situations in which you felt proud of yourself. Which memory comes to mind first?') 
     AND option_text = 'A moment when you solved a difficult problem.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Before making a decision, you think about situations in which you felt proud of yourself. Which memory comes to mind first?') 
     AND option_text = 'A moment when you solved a difficult problem.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Potential Exploration' LIMIT 1), 10);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Before making a decision, you think about situations in which you felt proud of yourself. Which memory comes to mind first?' ORDER BY id DESC LIMIT 1), 'A moment when you created, improved, or initiated something.', 'This may reveal creativity, initiative, and a willingness to shape your environment.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Before making a decision, you think about situations in which you felt proud of yourself. Which memory comes to mind first?') 
     AND option_text = 'A moment when you created, improved, or initiated something.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), 20);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Before making a decision, you think about situations in which you felt proud of yourself. Which memory comes to mind first?') 
     AND option_text = 'A moment when you created, improved, or initiated something.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Before making a decision, you think about situations in which you felt proud of yourself. Which memory comes to mind first?') 
     AND option_text = 'A moment when you created, improved, or initiated something.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Potential Exploration' LIMIT 1), 20);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 2: Looking for Clues' AND owner_id = (SELECT id FROM simulator WHERE title = 'The opportunity you didn''t expect') LIMIT 1), 'mcq', 2, LAST_INSERT_ID());

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'The opportunity you didn''t expect'), 3, 'Phase 3: Advice from a Friend', 'A different perspective', NULL, 'The way we explain success and opportunities often reveals our self-beliefs more than our actual abilities.');

-- Component 1 for Card 2
INSERT INTO component_text (content) VALUES ('You tell a trusted friend about the opportunity. They ask: "Why do you think you were invited?"');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 3: Advice from a Friend' AND owner_id = (SELECT id FROM simulator WHERE title = 'The opportunity you didn''t expect') LIMIT 1), 'text', 1, LAST_INSERT_ID());

-- Component 2 for Card 2
INSERT INTO component_mcq (question) VALUES ('You tell a trusted friend about the opportunity. They ask: "Why do you think you were invited?"');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You tell a trusted friend about the opportunity. They ask: "Why do you think you were invited?"' ORDER BY id DESC LIMIT 1), 'I''m not really sure. Maybe they just needed someone.', 'You may be overlooking the experience, qualities, or contributions that made others think of you.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You tell a trusted friend about the opportunity. They ask: "Why do you think you were invited?"') 
     AND option_text = 'I''m not really sure. Maybe they just needed someone.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), 0);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You tell a trusted friend about the opportunity. They ask: "Why do you think you were invited?"') 
     AND option_text = 'I''m not really sure. Maybe they just needed someone.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), 0);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You tell a trusted friend about the opportunity. They ask: "Why do you think you were invited?"') 
     AND option_text = 'I''m not really sure. Maybe they just needed someone.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Potential Exploration' LIMIT 1), 5);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You tell a trusted friend about the opportunity. They ask: "Why do you think you were invited?"' ORDER BY id DESC LIMIT 1), 'Probably because of some skills or experience I already have.', 'You acknowledge your strengths without exaggerating them. This creates a realistic foundation for confidence.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You tell a trusted friend about the opportunity. They ask: "Why do you think you were invited?"') 
     AND option_text = 'Probably because of some skills or experience I already have.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You tell a trusted friend about the opportunity. They ask: "Why do you think you were invited?"') 
     AND option_text = 'Probably because of some skills or experience I already have.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Confidence +20 Potential Exploration' LIMIT 1), 10);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You tell a trusted friend about the opportunity. They ask: "Why do you think you were invited?"' ORDER BY id DESC LIMIT 1), 'Maybe they see something in me that I haven''t fully recognized yet.', 'Interesting insight. Sometimes other people notice our potential before we do.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You tell a trusted friend about the opportunity. They ask: "Why do you think you were invited?"') 
     AND option_text = 'Maybe they see something in me that I haven''t fully recognized yet.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), 20);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You tell a trusted friend about the opportunity. They ask: "Why do you think you were invited?"') 
     AND option_text = 'Maybe they see something in me that I haven''t fully recognized yet.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You tell a trusted friend about the opportunity. They ask: "Why do you think you were invited?"') 
     AND option_text = 'Maybe they see something in me that I haven''t fully recognized yet.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Potential Exploration' LIMIT 1), 20);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 3: Advice from a Friend' AND owner_id = (SELECT id FROM simulator WHERE title = 'The opportunity you didn''t expect') LIMIT 1), 'mcq', 2, LAST_INSERT_ID());

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'The opportunity you didn''t expect'), 4, 'Phase 4: The Decision', 'Stepping forward', NULL, 'Potential grows through action. This question explores how you approach uncertainty and development opportunities.');

-- Component 1 for Card 3
INSERT INTO component_text (content) VALUES ('The deadline is tomorrow. You still feel some uncertainty, but you need to decide.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 4: The Decision' AND owner_id = (SELECT id FROM simulator WHERE title = 'The opportunity you didn''t expect') LIMIT 1), 'text', 1, LAST_INSERT_ID());

-- Component 2 for Card 3
INSERT INTO component_mcq (question) VALUES ('The deadline is tomorrow. You still feel some uncertainty, but you need to decide.');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'The deadline is tomorrow. You still feel some uncertainty, but you need to decide.' ORDER BY id DESC LIMIT 1), 'You decline because you don''t feel fully ready.', 'Preparation matters, but waiting until you feel completely ready may prevent valuable growth opportunities.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'The deadline is tomorrow. You still feel some uncertainty, but you need to decide.') 
     AND option_text = 'You decline because you don''t feel fully ready.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), 5);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'The deadline is tomorrow. You still feel some uncertainty, but you need to decide.') 
     AND option_text = 'You decline because you don''t feel fully ready.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), 0);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'The deadline is tomorrow. You still feel some uncertainty, but you need to decide.') 
     AND option_text = 'You decline because you don''t feel fully ready.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Potential Exploration' LIMIT 1), 0);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'The deadline is tomorrow. You still feel some uncertainty, but you need to decide.' ORDER BY id DESC LIMIT 1), 'You accept and decide to learn as you go.', 'Growth often happens when we combine existing strengths with new experiences.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'The deadline is tomorrow. You still feel some uncertainty, but you need to decide.') 
     AND option_text = 'You accept and decide to learn as you go.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'The deadline is tomorrow. You still feel some uncertainty, but you need to decide.') 
     AND option_text = 'You accept and decide to learn as you go.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), 20);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'The deadline is tomorrow. You still feel some uncertainty, but you need to decide.') 
     AND option_text = 'You accept and decide to learn as you go.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Potential Exploration' LIMIT 1), 20);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'The deadline is tomorrow. You still feel some uncertainty, but you need to decide.' ORDER BY id DESC LIMIT 1), 'You ask for more information and support before committing.', 'A thoughtful approach. Seeking clarity can help you stretch beyond your comfort zone without feeling overwhelmed.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'The deadline is tomorrow. You still feel some uncertainty, but you need to decide.') 
     AND option_text = 'You ask for more information and support before committing.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), 20);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'The deadline is tomorrow. You still feel some uncertainty, but you need to decide.') 
     AND option_text = 'You ask for more information and support before committing.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'The deadline is tomorrow. You still feel some uncertainty, but you need to decide.') 
     AND option_text = 'You ask for more information and support before committing.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Potential Exploration' LIMIT 1), 15);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 4: The Decision' AND owner_id = (SELECT id FROM simulator WHERE title = 'The opportunity you didn''t expect') LIMIT 1), 'mcq', 2, LAST_INSERT_ID());

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'The opportunity you didn''t expect'), 5, 'Phase 5: Reflection', 'Potential in action', 'You have completed the simulation. Remember: inner potential is not a hidden treasure waiting to be found—it is something that becomes clearer each time you explore, experiment, and reflect. Use what you learned here as a starting point for your next opportunity.', 'The final reflection helps transform a series of choices into a personal insight that can be applied beyond the simulation.');

-- Component 1 for Card 4
INSERT INTO component_text (content) VALUES ('Take a moment to reflect on your choices throughout this journey. What insight feels most true for you?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 5: Reflection' AND owner_id = (SELECT id FROM simulator WHERE title = 'The opportunity you didn''t expect') LIMIT 1), 'text', 1, LAST_INSERT_ID());

-- Component 2 for Card 4
INSERT INTO component_mcq (question) VALUES ('Take a moment to reflect on your choices throughout this journey. What insight feels most true for you?');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Take a moment to reflect on your choices throughout this journey. What insight feels most true for you?' ORDER BY id DESC LIMIT 1), 'I may have more strengths than I usually recognize.', 'A powerful realization. Self-awareness often begins with noticing abilities that have been there all along.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Take a moment to reflect on your choices throughout this journey. What insight feels most true for you?') 
     AND option_text = 'I may have more strengths than I usually recognize.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), 20);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Take a moment to reflect on your choices throughout this journey. What insight feels most true for you?') 
     AND option_text = 'I may have more strengths than I usually recognize.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Take a moment to reflect on your choices throughout this journey. What insight feels most true for you?') 
     AND option_text = 'I may have more strengths than I usually recognize.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Potential Exploration' LIMIT 1), 10);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Take a moment to reflect on your choices throughout this journey. What insight feels most true for you?' ORDER BY id DESC LIMIT 1), 'Growth doesn''t require certainty—it requires curiosity.', 'Excellent insight. Curiosity is one of the strongest drivers of learning and personal development.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Take a moment to reflect on your choices throughout this journey. What insight feels most true for you?') 
     AND option_text = 'Growth doesn''t require certainty—it requires curiosity.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Take a moment to reflect on your choices throughout this journey. What insight feels most true for you?') 
     AND option_text = 'Growth doesn''t require certainty—it requires curiosity.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Take a moment to reflect on your choices throughout this journey. What insight feels most true for you?') 
     AND option_text = 'Growth doesn''t require certainty—it requires curiosity.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Potential Exploration' LIMIT 1), 20);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Take a moment to reflect on your choices throughout this journey. What insight feels most true for you?' ORDER BY id DESC LIMIT 1), 'My potential becomes visible when I actually use it.', 'Very strong. Potential is not just something we possess—it is something we express through action.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Take a moment to reflect on your choices throughout this journey. What insight feels most true for you?') 
     AND option_text = 'My potential becomes visible when I actually use it.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), 20);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Take a moment to reflect on your choices throughout this journey. What insight feels most true for you?') 
     AND option_text = 'My potential becomes visible when I actually use it.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), 20);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Take a moment to reflect on your choices throughout this journey. What insight feels most true for you?') 
     AND option_text = 'My potential becomes visible when I actually use it.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Potential Exploration' LIMIT 1), 10);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 5: Reflection' AND owner_id = (SELECT id FROM simulator WHERE title = 'The opportunity you didn''t expect') LIMIT 1), 'mcq', 2, LAST_INSERT_ID());

-- ============================================
-- Feedback Tiers
-- ============================================

-- Feedback for metric 'Self-awareness' (Score 0-49)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'The opportunity you didn''t expect'), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), 0, 49, 'You are beginning a journey of self-discovery. Your answers suggest that you may have strengths and capabilities that are not yet fully visible to you.', 'You may underestimate your abilities or focus more on what is missing than on what is already working. As a result, you might overlook opportunities that match your strengths.', 'For the next 3 days, write down one thing you did well each day - even if it seems small. At the end of the week, look for patterns.', NULL, NULL);

-- Feedback for metric 'Self-awareness' (Score 50-85)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'The opportunity you didn''t expect'), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), 50, 85, 'You are developing a solid understanding of your strengths and personal resources. You can recognize many of the qualities that help you navigate challenges and achieve goals.', 'You still hesitate occasionally when challenged by senior peers. You may still dismiss some achievements as "nothing special" or assume that what comes naturally to you is not valuable.', 'Think of one achievement you are proud of. Ask yourself: What personal qualities helped me make this happen? Write down at least three.', NULL, NULL);

-- Feedback for metric 'Self-awareness' (Score 85-100)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'The opportunity you didn''t expect'), (SELECT id FROM simulator_metric WHERE name = 'Self-awareness' LIMIT 1), 85, 100, 'You have a strong awareness of your strengths, motivations, and behavioral patterns. You are able to learn from experience and use those insights to guide your decisions.', 'Self-awareness can sometimes stay at the level of reflection. Understanding yourself is powerful, but growth happens when insight is translated into action.', 'Choose one strength you identified during this game and intentionally use it in a new situation this week.', NULL, NULL);

-- Feedback for metric 'Confidence' (Score 0-49)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'The opportunity you didn''t expect'), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), 0, 49, 'You may approach decisions thoughtfully and carefully rather than acting impulsively. This can help you avoid rushing into situations without considering the consequences.', 'You may wait until you feel fully ready before taking action. This can lead to missed opportunities for growth and learning.', 'Think of one opportunity you have been hesitating about. Identify the smallest possible step you could take within the next 48 hours.', NULL, NULL);

-- Feedback for metric 'Confidence' (Score 50-85)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'The opportunity you didn''t expect'), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), 50, 85, 'You have a growing ability to trust yourself and your abilities. You are willing to take action in many situations, especially when you feel prepared.', 'Your confidence may still depend heavily on external validation, certainty, or having all the answers before moving forward.', 'At the end of each day, write down one challenge you handled successfully, even if it was something small.', NULL, NULL);

-- Feedback for metric 'Confidence' (Score 85-100)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'The opportunity you didn''t expect'), (SELECT id FROM simulator_metric WHERE name = 'Confidence' LIMIT 1), 85, 100, 'You trust your ability to learn, adapt, and respond to new situations. You do not need perfect certainty before taking action.', 'High confidence can sometimes lead to overlooking helpful feedback or underestimating potential obstacles.', 'Before your next important decision, ask one trusted person for their perspective and compare it with your own.', NULL, NULL);

-- Feedback for metric 'Potential exploration' (Score 0-49)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'The opportunity you didn''t expect'), (SELECT id FROM simulator_metric WHERE name = 'Potential exploration' LIMIT 1), 0, 49, 'You may value stability, consistency, and thoughtful decision-making. These qualities can provide a strong foundation for growth.', 'You may stay within familiar environments for too long and miss opportunities to discover new strengths and interests.', 'Try one small new experience this week: attend an event, learn a new skill, read about an unfamiliar topic, or start a conversation with someone new.', NULL, NULL);

-- Feedback for metric 'Potential exploration' (Score 50-85)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'The opportunity you didn''t expect'), (SELECT id FROM simulator_metric WHERE name = 'Potential exploration' LIMIT 1), 50, 85, 'You are open to learning and willing to consider new possibilities. You can balance curiosity with thoughtful reflection.', 'You may explore only when the benefits are obvious, missing opportunities that initially feel uncertain or uncomfortable.', 'Choose one opportunity you have been curious about and spend 15 minutes learning more about it.', NULL, NULL);

-- Feedback for metric 'Potential exploration' (Score 85-100)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'The opportunity you didn''t expect'), (SELECT id FROM simulator_metric WHERE name = 'Potential exploration' LIMIT 1), 85, 100, 'You actively seek opportunities to learn, grow, and expand your capabilities. You view challenges as chances to discover new aspects of yourself.', 'You may focus so much on new opportunities that you do not always pause to integrate what you have learned.', 'At the end of the week, reflect on one new experience and answer: What did this teach me about myself?', NULL, NULL);

-- ============================================
-- End of generated queries
-- ============================================
