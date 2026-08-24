-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:10.789415
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Simulator: Using Your Power Authentically
-- ============================================
INSERT INTO simulator (title, description, level, localisation, estimated_duration, created_at) VALUES ('Using Your Power Authentically', 'No description', 'core', 'Work / Community', 10, '2026-08-23 19:54:10.788646');

-- Simulator Tags
INSERT INTO simulator_tag (name) VALUES ('Authentic Leadership');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'Using Your Power Authentically'), (SELECT id FROM simulator_tag WHERE name = 'Authentic Leadership' LIMIT 1));
INSERT INTO simulator_tag (name) VALUES ('Boundaries');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'Using Your Power Authentically'), (SELECT id FROM simulator_tag WHERE name = 'Boundaries' LIMIT 1));
INSERT INTO simulator_tag (name) VALUES ('Influence');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'Using Your Power Authentically'), (SELECT id FROM simulator_tag WHERE name = 'Influence' LIMIT 1));
INSERT INTO simulator_tag (name) VALUES ('Decision-Making');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'Using Your Power Authentically'), (SELECT id FROM simulator_tag WHERE name = 'Decision-Making' LIMIT 1));
INSERT INTO simulator_tag (name) VALUES ('Women’s Leadership');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'Using Your Power Authentically'), (SELECT id FROM simulator_tag WHERE name = 'Women’s Leadership' LIMIT 1));

-- Simulator Metrics
INSERT INTO simulator_metric (name) VALUES ('Authenticity');
INSERT INTO simulator_contains_metric (simulator_id, metric_id) VALUES ((SELECT id FROM simulator WHERE title = 'Using Your Power Authentically'), (SELECT id FROM simulator_metric WHERE name = 'Authenticity' LIMIT 1));
INSERT INTO simulator_metric (name) VALUES ('Boundaries');
INSERT INTO simulator_contains_metric (simulator_id, metric_id) VALUES ((SELECT id FROM simulator WHERE title = 'Using Your Power Authentically'), (SELECT id FROM simulator_metric WHERE name = 'Boundaries' LIMIT 1));
INSERT INTO simulator_metric (name) VALUES ('Influence');
INSERT INTO simulator_contains_metric (simulator_id, metric_id) VALUES ((SELECT id FROM simulator WHERE title = 'Using Your Power Authentically'), (SELECT id FROM simulator_metric WHERE name = 'Influence' LIMIT 1));

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'Using Your Power Authentically'), 1, 'Phase 1: The Request', 'When leadership becomes expectation', 'A pause is already a leadership move. It gives you time to choose intentionally instead of reacting from guilt or habit.', 'This question introduces the difference between helpfulness and over-functioning. It helps learners notice how power can be lost when they automatically accept responsibility for everything.');

-- Component 1 for Card 0
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1h1LvZWhyc-rtaLCUPErR7uLxEyXC7x3g/view?usp=drive_link', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 1: The Request' AND owner_id = (SELECT id FROM simulator WHERE title = 'Using Your Power Authentically') LIMIT 1), 'image', 1, LAST_INSERT_ID());

-- Component 2 for Card 0
INSERT INTO component_text (content) VALUES ('You are part of a team preparing an important initiative. Because you are reliable and organised, others often turn to you when something needs to be fixed. Today, a colleague asks you to take over an extra task, even though your own workload is already full.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 1: The Request' AND owner_id = (SELECT id FROM simulator WHERE title = 'Using Your Power Authentically') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 0
INSERT INTO component_mcq (question) VALUES ('You are part of a team preparing an important initiative. Because you are reliable and organised, others often turn to you when something needs to be fixed. Today, a colleague asks you to take over an extra task, even though your own workload is already full.');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You are part of a team preparing an important initiative. Because you are reliable and organised, others often turn to you when something needs to be fixed. Today, a colleague asks you to take over an extra task, even though your own workload is already full.' ORDER BY id DESC LIMIT 1), 'You reply sharply: “No, I’m not doing everyone else’s work again.”', 'Your frustration may be understandable, but the response may damage collaboration. A boundary is stronger when it is clear without becoming explosive.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You are part of a team preparing an important initiative. Because you are reliable and organised, others often turn to you when something needs to be fixed. Today, a colleague asks you to take over an extra task, even though your own workload is already full.') 
     AND option_text = 'You reply sharply: “No, I’m not doing everyone else’s work again.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Authenticity' LIMIT 1), 5);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You are part of a team preparing an important initiative. Because you are reliable and organised, others often turn to you when something needs to be fixed. Today, a colleague asks you to take over an extra task, even though your own workload is already full.') 
     AND option_text = 'You reply sharply: “No, I’m not doing everyone else’s work again.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Boundaries' LIMIT 1), 10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You are part of a team preparing an important initiative. Because you are reliable and organised, others often turn to you when something needs to be fixed. Today, a colleague asks you to take over an extra task, even though your own workload is already full.') 
     AND option_text = 'You reply sharply: “No, I’m not doing everyone else’s work again.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Influence' LIMIT 1), -10);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You are part of a team preparing an important initiative. Because you are reliable and organised, others often turn to you when something needs to be fixed. Today, a colleague asks you to take over an extra task, even though your own workload is already full.' ORDER BY id DESC LIMIT 1), 'You immediately say yes, because you do not want to disappoint anyone.', 'This shows care and responsibility, but it may also repeat a pattern where your reliability becomes unlimited availability.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You are part of a team preparing an important initiative. Because you are reliable and organised, others often turn to you when something needs to be fixed. Today, a colleague asks you to take over an extra task, even though your own workload is already full.') 
     AND option_text = 'You immediately say yes, because you do not want to disappoint anyone.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Authenticity' LIMIT 1), -5);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You are part of a team preparing an important initiative. Because you are reliable and organised, others often turn to you when something needs to be fixed. Today, a colleague asks you to take over an extra task, even though your own workload is already full.') 
     AND option_text = 'You immediately say yes, because you do not want to disappoint anyone.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Boundaries' LIMIT 1), -15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You are part of a team preparing an important initiative. Because you are reliable and organised, others often turn to you when something needs to be fixed. Today, a colleague asks you to take over an extra task, even though your own workload is already full.') 
     AND option_text = 'You immediately say yes, because you do not want to disappoint anyone.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Influence' LIMIT 1), 5);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You are part of a team preparing an important initiative. Because you are reliable and organised, others often turn to you when something needs to be fixed. Today, a colleague asks you to take over an extra task, even though your own workload is already full.' ORDER BY id DESC LIMIT 1), 'You pause and say: “Let me check my current priorities before I answer.”', 'Strong choice. You create space before committing. This protects your time and helps you respond from clarity rather than pressure.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You are part of a team preparing an important initiative. Because you are reliable and organised, others often turn to you when something needs to be fixed. Today, a colleague asks you to take over an extra task, even though your own workload is already full.') 
     AND option_text = 'You pause and say: “Let me check my current priorities before I answer.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Authenticity' LIMIT 1), 10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You are part of a team preparing an important initiative. Because you are reliable and organised, others often turn to you when something needs to be fixed. Today, a colleague asks you to take over an extra task, even though your own workload is already full.') 
     AND option_text = 'You pause and say: “Let me check my current priorities before I answer.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Boundaries' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You are part of a team preparing an important initiative. Because you are reliable and organised, others often turn to you when something needs to be fixed. Today, a colleague asks you to take over an extra task, even though your own workload is already full.') 
     AND option_text = 'You pause and say: “Let me check my current priorities before I answer.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Influence' LIMIT 1), 5);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 1: The Request' AND owner_id = (SELECT id FROM simulator WHERE title = 'Using Your Power Authentically') LIMIT 1), 'mcq', 3, LAST_INSERT_ID());

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'Using Your Power Authentically'), 2, 'Phase 2: The Decision', 'Choosing without disappearing', 'You can be supportive without becoming responsible for everything. Clarity protects both your energy and the team’s planning.', 'This question helps learners practise a clear, balanced response. Authentic power is not only about saying yes or no; it is about responding honestly and constructively.');

-- Component 1 for Card 1
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1w70EenEt2T2m2VxM7hpm2gwxy1Qfn_5G/view?usp=drive_link', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 2: The Decision' AND owner_id = (SELECT id FROM simulator WHERE title = 'Using Your Power Authentically') LIMIT 1), 'image', 1, LAST_INSERT_ID());

-- Component 2 for Card 1
INSERT INTO component_text (content) VALUES ('You know the task is important, but saying yes would mean working late again. You also worry that saying no may make you seem unhelpful or less committed. The colleague is waiting for your answer.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 2: The Decision' AND owner_id = (SELECT id FROM simulator WHERE title = 'Using Your Power Authentically') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 1
INSERT INTO component_mcq (question) VALUES ('You know the task is important, but saying yes would mean working late again. You also worry that saying no may make you seem unhelpful or less committed. The colleague is waiting for your answer.');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You know the task is important, but saying yes would mean working late again. You also worry that saying no may make you seem unhelpful or less committed. The colleague is waiting for your answer.' ORDER BY id DESC LIMIT 1), 'You say: “Okay, I’ll do it,” even though you know it will overload you.', 'This may protect harmony in the short term, but it weakens your boundary and may make your own priorities invisible.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You know the task is important, but saying yes would mean working late again. You also worry that saying no may make you seem unhelpful or less committed. The colleague is waiting for your answer.') 
     AND option_text = 'You say: “Okay, I’ll do it,” even though you know it will overload you.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Authenticity' LIMIT 1), -10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You know the task is important, but saying yes would mean working late again. You also worry that saying no may make you seem unhelpful or less committed. The colleague is waiting for your answer.') 
     AND option_text = 'You say: “Okay, I’ll do it,” even though you know it will overload you.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Boundaries' LIMIT 1), -15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You know the task is important, but saying yes would mean working late again. You also worry that saying no may make you seem unhelpful or less committed. The colleague is waiting for your answer.') 
     AND option_text = 'You say: “Okay, I’ll do it,” even though you know it will overload you.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Influence' LIMIT 1), 0);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You know the task is important, but saying yes would mean working late again. You also worry that saying no may make you seem unhelpful or less committed. The colleague is waiting for your answer.' ORDER BY id DESC LIMIT 1), 'You say: “I cannot take this over today, but I can help you think through the first step.”', 'Excellent. You are not abandoning the team. You are setting a limit while still offering constructive support.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You know the task is important, but saying yes would mean working late again. You also worry that saying no may make you seem unhelpful or less committed. The colleague is waiting for your answer.') 
     AND option_text = 'You say: “I cannot take this over today, but I can help you think through the first step.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Authenticity' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You know the task is important, but saying yes would mean working late again. You also worry that saying no may make you seem unhelpful or less committed. The colleague is waiting for your answer.') 
     AND option_text = 'You say: “I cannot take this over today, but I can help you think through the first step.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Boundaries' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You know the task is important, but saying yes would mean working late again. You also worry that saying no may make you seem unhelpful or less committed. The colleague is waiting for your answer.') 
     AND option_text = 'You say: “I cannot take this over today, but I can help you think through the first step.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Influence' LIMIT 1), 10);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You know the task is important, but saying yes would mean working late again. You also worry that saying no may make you seem unhelpful or less committed. The colleague is waiting for your answer.' ORDER BY id DESC LIMIT 1), 'You avoid answering clearly and say: “Maybe… I’ll see what I can do.”', 'This feels softer, but it creates ambiguity. Unclear boundaries often become hidden commitments.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You know the task is important, but saying yes would mean working late again. You also worry that saying no may make you seem unhelpful or less committed. The colleague is waiting for your answer.') 
     AND option_text = 'You avoid answering clearly and say: “Maybe… I’ll see what I can do.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Authenticity' LIMIT 1), -5);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You know the task is important, but saying yes would mean working late again. You also worry that saying no may make you seem unhelpful or less committed. The colleague is waiting for your answer.') 
     AND option_text = 'You avoid answering clearly and say: “Maybe… I’ll see what I can do.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Boundaries' LIMIT 1), -10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You know the task is important, but saying yes would mean working late again. You also worry that saying no may make you seem unhelpful or less committed. The colleague is waiting for your answer.') 
     AND option_text = 'You avoid answering clearly and say: “Maybe… I’ll see what I can do.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Influence' LIMIT 1), -5);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 2: The Decision' AND owner_id = (SELECT id FROM simulator WHERE title = 'Using Your Power Authentically') LIMIT 1), 'mcq', 3, LAST_INSERT_ID());

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'Using Your Power Authentically'), 3, 'Phase 3: The Pushback', 'Staying steady under pressure', 'A boundary may need to be stated more than once. Staying calm does not make it weaker; it often makes it more credible.', 'This question explores what happens when a boundary is tested. Learners practise staying steady without escalating, apologising excessively, or collapsing.');

-- Component 1 for Card 2
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1vHIBrzDIOXrBjc_vdWt2loV-H4-2XfR9/view?usp=drive_link', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 3: The Pushback' AND owner_id = (SELECT id FROM simulator WHERE title = 'Using Your Power Authentically') LIMIT 1), 'image', 1, LAST_INSERT_ID());

-- Component 2 for Card 2
INSERT INTO component_text (content) VALUES ('Your colleague says: “But you’re the best person for this. It will only take you a little time.” You feel the familiar pressure to say yes, even though you know it will affect your priorities.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 3: The Pushback' AND owner_id = (SELECT id FROM simulator WHERE title = 'Using Your Power Authentically') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 2
INSERT INTO component_mcq (question) VALUES ('Your colleague says: “But you’re the best person for this. It will only take you a little time.” You feel the familiar pressure to say yes, even though you know it will affect your priorities.');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Your colleague says: “But you’re the best person for this. It will only take you a little time.” You feel the familiar pressure to say yes, even though you know it will affect your priorities.' ORDER BY id DESC LIMIT 1), 'You say: “Why does everyone always expect me to solve things?”', 'The concern may be valid, but the phrasing shifts the focus toward blame. It may reduce your influence in the moment.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Your colleague says: “But you’re the best person for this. It will only take you a little time.” You feel the familiar pressure to say yes, even though you know it will affect your priorities.') 
     AND option_text = 'You say: “Why does everyone always expect me to solve things?”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Authenticity' LIMIT 1), 5);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Your colleague says: “But you’re the best person for this. It will only take you a little time.” You feel the familiar pressure to say yes, even though you know it will affect your priorities.') 
     AND option_text = 'You say: “Why does everyone always expect me to solve things?”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Boundaries' LIMIT 1), 5);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Your colleague says: “But you’re the best person for this. It will only take you a little time.” You feel the familiar pressure to say yes, even though you know it will affect your priorities.') 
     AND option_text = 'You say: “Why does everyone always expect me to solve things?”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Influence' LIMIT 1), -10);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Your colleague says: “But you’re the best person for this. It will only take you a little time.” You feel the familiar pressure to say yes, even though you know it will affect your priorities.' ORDER BY id DESC LIMIT 1), 'You give in and say: “Fine, send it to me.”', 'This may end the discomfort quickly, but it teaches others that your boundaries can be negotiated away with enough pressure.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Your colleague says: “But you’re the best person for this. It will only take you a little time.” You feel the familiar pressure to say yes, even though you know it will affect your priorities.') 
     AND option_text = 'You give in and say: “Fine, send it to me.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Authenticity' LIMIT 1), -10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Your colleague says: “But you’re the best person for this. It will only take you a little time.” You feel the familiar pressure to say yes, even though you know it will affect your priorities.') 
     AND option_text = 'You give in and say: “Fine, send it to me.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Boundaries' LIMIT 1), -15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Your colleague says: “But you’re the best person for this. It will only take you a little time.” You feel the familiar pressure to say yes, even though you know it will affect your priorities.') 
     AND option_text = 'You give in and say: “Fine, send it to me.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Influence' LIMIT 1), -5);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Your colleague says: “But you’re the best person for this. It will only take you a little time.” You feel the familiar pressure to say yes, even though you know it will affect your priorities.' ORDER BY id DESC LIMIT 1), 'You repeat calmly: “I understand it matters. I still cannot take it over today.”', 'Very strong. You acknowledge the need without abandoning your limit. Repeating a boundary calmly is a key leadership skill.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Your colleague says: “But you’re the best person for this. It will only take you a little time.” You feel the familiar pressure to say yes, even though you know it will affect your priorities.') 
     AND option_text = 'You repeat calmly: “I understand it matters. I still cannot take it over today.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Authenticity' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Your colleague says: “But you’re the best person for this. It will only take you a little time.” You feel the familiar pressure to say yes, even though you know it will affect your priorities.') 
     AND option_text = 'You repeat calmly: “I understand it matters. I still cannot take it over today.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Boundaries' LIMIT 1), 20);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Your colleague says: “But you’re the best person for this. It will only take you a little time.” You feel the familiar pressure to say yes, even though you know it will affect your priorities.') 
     AND option_text = 'You repeat calmly: “I understand it matters. I still cannot take it over today.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Influence' LIMIT 1), 10);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 3: The Pushback' AND owner_id = (SELECT id FROM simulator WHERE title = 'Using Your Power Authentically') LIMIT 1), 'mcq', 3, LAST_INSERT_ID());

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'Using Your Power Authentically'), 4, 'Phase 4: The Alternative', 'Power as shared responsibility', 'Power is not only personal strength. It is also the ability to create healthier ways of working with others.', 'This question reframes leadership as enabling shared ownership. The learner practises influencing the system, not simply carrying the system.');

-- Component 1 for Card 3
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1NdC-eTrzPCXZ9rTtv1E7C_tfWU6cY7we/view?usp=drive_link', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 4: The Alternative' AND owner_id = (SELECT id FROM simulator WHERE title = 'Using Your Power Authentically') LIMIT 1), 'image', 1, LAST_INSERT_ID());

-- Component 2 for Card 3
INSERT INTO component_text (content) VALUES ('You decide not to take over the task fully, but you want to remain constructive. You consider how to support the team without carrying everything yourself.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 4: The Alternative' AND owner_id = (SELECT id FROM simulator WHERE title = 'Using Your Power Authentically') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 3
INSERT INTO component_mcq (question) VALUES ('You decide not to take over the task fully, but you want to remain constructive. You consider how to support the team without carrying everything yourself.');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You decide not to take over the task fully, but you want to remain constructive. You consider how to support the team without carrying everything yourself.' ORDER BY id DESC LIMIT 1), 'You suggest that the team quickly redistributes the task and agrees who can take which part.', 'Excellent. You move from individual rescue to shared responsibility. This is authentic, practical influence.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You decide not to take over the task fully, but you want to remain constructive. You consider how to support the team without carrying everything yourself.') 
     AND option_text = 'You suggest that the team quickly redistributes the task and agrees who can take which part.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Authenticity' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You decide not to take over the task fully, but you want to remain constructive. You consider how to support the team without carrying everything yourself.') 
     AND option_text = 'You suggest that the team quickly redistributes the task and agrees who can take which part.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Boundaries' LIMIT 1), 10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You decide not to take over the task fully, but you want to remain constructive. You consider how to support the team without carrying everything yourself.') 
     AND option_text = 'You suggest that the team quickly redistributes the task and agrees who can take which part.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Influence' LIMIT 1), 20);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You decide not to take over the task fully, but you want to remain constructive. You consider how to support the team without carrying everything yourself.' ORDER BY id DESC LIMIT 1), 'You decide not to engage at all because “it is not your problem anymore.”', 'You protect your time, but you may also lose an opportunity to influence the team culture in a constructive way.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You decide not to take over the task fully, but you want to remain constructive. You consider how to support the team without carrying everything yourself.') 
     AND option_text = 'You decide not to engage at all because “it is not your problem anymore.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Authenticity' LIMIT 1), 5);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You decide not to take over the task fully, but you want to remain constructive. You consider how to support the team without carrying everything yourself.') 
     AND option_text = 'You decide not to engage at all because “it is not your problem anymore.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Boundaries' LIMIT 1), 10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You decide not to take over the task fully, but you want to remain constructive. You consider how to support the team without carrying everything yourself.') 
     AND option_text = 'You decide not to engage at all because “it is not your problem anymore.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Influence' LIMIT 1), -10);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You decide not to take over the task fully, but you want to remain constructive. You consider how to support the team without carrying everything yourself.' ORDER BY id DESC LIMIT 1), 'You secretly do part of the task later so that things do not fall apart.', 'This keeps the project moving, but it undermines your own boundary and hides the real workload problem from the team.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You decide not to take over the task fully, but you want to remain constructive. You consider how to support the team without carrying everything yourself.') 
     AND option_text = 'You secretly do part of the task later so that things do not fall apart.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Authenticity' LIMIT 1), -10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You decide not to take over the task fully, but you want to remain constructive. You consider how to support the team without carrying everything yourself.') 
     AND option_text = 'You secretly do part of the task later so that things do not fall apart.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Boundaries' LIMIT 1), -15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You decide not to take over the task fully, but you want to remain constructive. You consider how to support the team without carrying everything yourself.') 
     AND option_text = 'You secretly do part of the task later so that things do not fall apart.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Influence' LIMIT 1), 5);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 4: The Alternative' AND owner_id = (SELECT id FROM simulator WHERE title = 'Using Your Power Authentically') LIMIT 1), 'mcq', 3, LAST_INSERT_ID());

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'Using Your Power Authentically'), 5, 'Phase 5: Reflection', 'Leading without over-functioning', 'You have completed the simulator. Your result reflects how you currently use your power in relation to others. Authentic leadership does not mean doing everything. It means acting with clarity, integrity, and purpose.', 'This final question supports consolidation. It helps learners connect authentic leadership with sustainable participation, boundaries, and influence.');

-- Component 1 for Card 4
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/12RyIptaK71Ui6eReSB13lo-uFs05jEzh/view?usp=drive_link', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 5: Reflection' AND owner_id = (SELECT id FROM simulator WHERE title = 'Using Your Power Authentically') LIMIT 1), 'image', 1, LAST_INSERT_ID());

-- Component 2 for Card 4
INSERT INTO component_text (content) VALUES ('At the end of the day, the task is still moving forward, but not only because of you. You realise that authentic leadership may include helping the group take responsibility, instead of quietly absorbing every burden yourself.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 5: Reflection' AND owner_id = (SELECT id FROM simulator WHERE title = 'Using Your Power Authentically') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 4
INSERT INTO component_mcq (question) VALUES ('At the end of the day, the task is still moving forward, but not only because of you. You realise that authentic leadership may include helping the group take responsibility, instead of quietly absorbing every burden yourself.');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'At the end of the day, the task is still moving forward, but not only because of you. You realise that authentic leadership may include helping the group take responsibility, instead of quietly absorbing every burden yourself.' ORDER BY id DESC LIMIT 1), 'You reflect: “I led today by being clear about what I could and could not take on.”', 'Strong reflection. You recognise that leadership includes clarity, limits, and self-respect.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'At the end of the day, the task is still moving forward, but not only because of you. You realise that authentic leadership may include helping the group take responsibility, instead of quietly absorbing every burden yourself.') 
     AND option_text = 'You reflect: “I led today by being clear about what I could and could not take on.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Authenticity' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'At the end of the day, the task is still moving forward, but not only because of you. You realise that authentic leadership may include helping the group take responsibility, instead of quietly absorbing every burden yourself.') 
     AND option_text = 'You reflect: “I led today by being clear about what I could and could not take on.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Boundaries' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'At the end of the day, the task is still moving forward, but not only because of you. You realise that authentic leadership may include helping the group take responsibility, instead of quietly absorbing every burden yourself.') 
     AND option_text = 'You reflect: “I led today by being clear about what I could and could not take on.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Influence' LIMIT 1), 10);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'At the end of the day, the task is still moving forward, but not only because of you. You realise that authentic leadership may include helping the group take responsibility, instead of quietly absorbing every burden yourself.' ORDER BY id DESC LIMIT 1), 'You reflect: “I feel guilty. Maybe I should have just done it.”', 'This is a common reaction, especially when you are used to being the reliable one. But guilt does not always mean you did something wrong.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'At the end of the day, the task is still moving forward, but not only because of you. You realise that authentic leadership may include helping the group take responsibility, instead of quietly absorbing every burden yourself.') 
     AND option_text = 'You reflect: “I feel guilty. Maybe I should have just done it.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Authenticity' LIMIT 1), -5);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'At the end of the day, the task is still moving forward, but not only because of you. You realise that authentic leadership may include helping the group take responsibility, instead of quietly absorbing every burden yourself.') 
     AND option_text = 'You reflect: “I feel guilty. Maybe I should have just done it.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Boundaries' LIMIT 1), -10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'At the end of the day, the task is still moving forward, but not only because of you. You realise that authentic leadership may include helping the group take responsibility, instead of quietly absorbing every burden yourself.') 
     AND option_text = 'You reflect: “I feel guilty. Maybe I should have just done it.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Influence' LIMIT 1), 0);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'At the end of the day, the task is still moving forward, but not only because of you. You realise that authentic leadership may include helping the group take responsibility, instead of quietly absorbing every burden yourself.' ORDER BY id DESC LIMIT 1), 'You reflect: “Next time, I can set the boundary earlier and help the team plan differently.”', 'Excellent. You turn the experience into learning and future action. This strengthens both personal power and collective responsibility.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'At the end of the day, the task is still moving forward, but not only because of you. You realise that authentic leadership may include helping the group take responsibility, instead of quietly absorbing every burden yourself.') 
     AND option_text = 'You reflect: “Next time, I can set the boundary earlier and help the team plan differently.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Authenticity' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'At the end of the day, the task is still moving forward, but not only because of you. You realise that authentic leadership may include helping the group take responsibility, instead of quietly absorbing every burden yourself.') 
     AND option_text = 'You reflect: “Next time, I can set the boundary earlier and help the team plan differently.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Boundaries' LIMIT 1), 10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'At the end of the day, the task is still moving forward, but not only because of you. You realise that authentic leadership may include helping the group take responsibility, instead of quietly absorbing every burden yourself.') 
     AND option_text = 'You reflect: “Next time, I can set the boundary earlier and help the team plan differently.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Influence' LIMIT 1), 15);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 5: Reflection' AND owner_id = (SELECT id FROM simulator WHERE title = 'Using Your Power Authentically') LIMIT 1), 'mcq', 3, LAST_INSERT_ID());

-- ============================================
-- Feedback Tiers
-- ============================================

-- Feedback for metric 'Authenticity' (Score 0-49)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Using Your Power Authentically'), (SELECT id FROM simulator_metric WHERE name = 'Authenticity' LIMIT 1), 0, 49, 'You are beginning to notice the difference between what others expect from you and what feels sustainable or true for you.', 'You may adapt too much to others’ needs, which can make your own priorities and values less visible.', 'Before saying yes, ask yourself: “Am I choosing this freely, or am I reacting from guilt or pressure?”', NULL, 'This module can help you clarify your values, needs, and leadership identity.');

-- Feedback for metric 'Authenticity' (Score 50-85)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Using Your Power Authentically'), (SELECT id FROM simulator_metric WHERE name = 'Authenticity' LIMIT 1), 50, 85, 'You are becoming more able to act in ways that reflect your values and limits.', 'In moments of pressure, you may still slip into old patterns of pleasing, proving, or over-explaining.', 'Practise one honest sentence: “I can support this in this way, but I cannot take it over.”', NULL, 'This module can help you express your leadership style with more clarity and confidence.');

-- Feedback for metric 'Authenticity' (Score 85-100)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Using Your Power Authentically'), (SELECT id FROM simulator_metric WHERE name = 'Authenticity' LIMIT 1), 85, 100, 'You show a strong ability to lead in a way that feels grounded, honest, and aligned with your values.', 'None. You already have a strong base for authentic leadership.', 'Once a week, reflect on one moment when your actions matched your values.', NULL, 'This module can help you expand authentic leadership into decision-making, communication, and influence.');

-- Feedback for metric 'Boundaries' (Score 0-49)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Using Your Power Authentically'), (SELECT id FROM simulator_metric WHERE name = 'Boundaries' LIMIT 1), 0, 49, 'You have the potential to affect how others work together, but you may not always use it visibly.', 'You may say yes too quickly, take on too much, or confuse being helpful with being constantly available.', 'Use a pause phrase: “Let me check my priorities before I confirm.”', NULL, 'This module can help you recognise personal patterns and protect your energy more intentionally.');

-- Feedback for metric 'Boundaries' (Score 50-85)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Using Your Power Authentically'), (SELECT id FROM simulator_metric WHERE name = 'Boundaries' LIMIT 1), 50, 85, 'You are learning to set limits while remaining collaborative.', 'You may still soften boundaries too much when others push back or express disappointment.', 'Practise repeating a boundary once without adding a long explanation.', NULL, 'This module can help you use boundaries as part of responsible and sustainable leadership.');

-- Feedback for metric 'Boundaries' (Score 85-100)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Using Your Power Authentically'), (SELECT id FROM simulator_metric WHERE name = 'Boundaries' LIMIT 1), 85, 100, 'You can set clear limits while staying respectful and constructive.', 'None. Your boundaries support both your wellbeing and your leadership credibility.', 'Identify one recurring situation where an earlier boundary would improve collaboration.', NULL, 'This module can help you strengthen leadership practices that prevent overload and support shared responsibility.');

-- Feedback for metric 'Influence' (Score 0-49)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Using Your Power Authentically'), (SELECT id FROM simulator_metric WHERE name = 'Influence' LIMIT 1), 0, 49, 'You have the potential to affect how others work together, but you may not always use it visibly.', 'You may withdraw, over-function, or solve problems privately instead of helping the group improve its way of working.', 'In your next team situation, ask: “How can we share this responsibility?”', NULL, 'This module can help you understand influence as a practical leadership skill.');

-- Feedback for metric 'Influence' (Score 50-85)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Using Your Power Authentically'), (SELECT id FROM simulator_metric WHERE name = 'Influence' LIMIT 1), 50, 85, 'You are developing constructive influence and can help move situations forward.', 'You may still rely too much on personal effort instead of shaping shared processes or decisions.', 'When a problem appears, suggest one next step and one person or role that can support it.', NULL, 'This module can help you practise influence through communication, decision-making, and shared responsibility.');

-- Feedback for metric 'Influence' (Score 85-100)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Using Your Power Authentically'), (SELECT id FROM simulator_metric WHERE name = 'Influence' LIMIT 1), 85, 100, 'You use your power constructively by helping others take responsibility and move forward together.', 'None. You show strong potential for collaborative and authentic leadership.', 'Notice one moment each week when your input helped the group act more clearly or fairly.', NULL, 'This module can help you deepen your ability to lead change with others, not only for others.');

-- ============================================
-- End of generated queries
-- ============================================
