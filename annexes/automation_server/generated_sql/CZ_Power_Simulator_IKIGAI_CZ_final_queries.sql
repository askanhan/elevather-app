-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:10.803620
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Simulator: Find your IKIGAI: Purpose discovering challenge
-- ============================================
INSERT INTO simulator (title, description, level, localisation, estimated_duration, created_at) VALUES ('Find your IKIGAI: Purpose discovering challenge', 'No description', 'core', 'Personal/Work', 15, '2026-08-23 19:54:10.802787');

-- Simulator Tags
INSERT INTO simulator_tag (name) VALUES ('Purpose');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge'), (SELECT id FROM simulator_tag WHERE name = 'Purpose' LIMIT 1));
INSERT INTO simulator_tag (name) VALUES ('Self-awareness');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge'), (SELECT id FROM simulator_tag WHERE name = 'Self-awareness' LIMIT 1));
INSERT INTO simulator_tag (name) VALUES ('Career development');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge'), (SELECT id FROM simulator_tag WHERE name = 'Career development' LIMIT 1));
INSERT INTO simulator_tag (name) VALUES ('Ikigai');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge'), (SELECT id FROM simulator_tag WHERE name = 'Ikigai' LIMIT 1));

-- Simulator Metrics
INSERT INTO simulator_metric (name) VALUES ('Purpose clarity');
INSERT INTO simulator_contains_metric (simulator_id, metric_id) VALUES ((SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge'), (SELECT id FROM simulator_metric WHERE name = 'Purpose clarity' LIMIT 1));
INSERT INTO simulator_metric (name) VALUES ('Alignment');
INSERT INTO simulator_contains_metric (simulator_id, metric_id) VALUES ((SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge'), (SELECT id FROM simulator_metric WHERE name = 'Alignment' LIMIT 1));
INSERT INTO simulator_metric (name) VALUES ('Courage to act');
INSERT INTO simulator_contains_metric (simulator_id, metric_id) VALUES ((SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge'), (SELECT id FROM simulator_metric WHERE name = 'Courage to act' LIMIT 1));

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge'), 1, 'Phase 1: Awareness', 'Getting ready', 'Every IKIGAI journey begins with noticing. There is no wrong answer here — only a starting point.', 'This opening question activates self-reflection and introduces the four IKIGAI dimensions. It reveals the learner''s default mode — avoidance, skill-focus, or energy-led exploration — and sets the tone for the rest of the simulator.');

-- Component 1 for Card 0
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://images.unsplash.com/photo-1455390582262-044cdead277a', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 1: Awareness' AND owner_id = (SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge') LIMIT 1), 'image', 1, LAST_INSERT_ID());

-- Component 2 for Card 0
INSERT INTO component_text (content) VALUES ('Mapping your inner world – You have 2 minutes to reflect: What do you love, what are you good at, what does the world need, and what can you be paid for? Which area is easiest for you to define?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 1: Awareness' AND owner_id = (SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 0
INSERT INTO component_mcq (question) VALUES ('Mapping your inner world – You have 2 minutes to reflect: What do you love, what are you good at, what does the world need, and what can you be paid for? Which area is easiest for you to define?');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Mapping your inner world – You have 2 minutes to reflect: What do you love, what are you good at, what does the world need, and what can you be paid for? Which area is easiest for you to define?' ORDER BY id DESC LIMIT 1), 'You write a long list of everything you love, are good at, what the world needs, and what pays well - but find it hard to choose one answer for any category.', 'Exploring everything at once can feel overwhelming. Awareness does not require perfection. The goal is noticing, not solving - start with the area that comes most naturally.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Mapping your inner world – You have 2 minutes to reflect: What do you love, what are you good at, what does the world need, and what can you be paid for? Which area is easiest for you to define?') 
     AND option_text = 'You write a long list of everything you love, are good at, what the world needs, and what pays well - but find it hard to choose one answer for any category.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Purpose clarity' LIMIT 1), 5);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Mapping your inner world – You have 2 minutes to reflect: What do you love, what are you good at, what does the world need, and what can you be paid for? Which area is easiest for you to define?') 
     AND option_text = 'You write a long list of everything you love, are good at, what the world needs, and what pays well - but find it hard to choose one answer for any category.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Alignment' LIMIT 1), 5);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Mapping your inner world – You have 2 minutes to reflect: What do you love, what are you good at, what does the world need, and what can you be paid for? Which area is easiest for you to define?') 
     AND option_text = 'You write a long list of everything you love, are good at, what the world needs, and what pays well - but find it hard to choose one answer for any category.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Courage to act' LIMIT 1), -5);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Mapping your inner world – You have 2 minutes to reflect: What do you love, what are you good at, what does the world need, and what can you be paid for? Which area is easiest for you to define?' ORDER BY id DESC LIMIT 1), 'You focus only on what you are good at, because that feels safest and most concrete.', 'Skill is one powerful piece of the IKIGAI puzzle, but focusing only there can leave meaning and motivation out. Try adding: what gives you energy alongside what you do well?');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Mapping your inner world – You have 2 minutes to reflect: What do you love, what are you good at, what does the world need, and what can you be paid for? Which area is easiest for you to define?') 
     AND option_text = 'You focus only on what you are good at, because that feels safest and most concrete.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Purpose clarity' LIMIT 1), 5);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Mapping your inner world – You have 2 minutes to reflect: What do you love, what are you good at, what does the world need, and what can you be paid for? Which area is easiest for you to define?') 
     AND option_text = 'You focus only on what you are good at, because that feels safest and most concrete.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Alignment' LIMIT 1), -5);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Mapping your inner world – You have 2 minutes to reflect: What do you love, what are you good at, what does the world need, and what can you be paid for? Which area is easiest for you to define?') 
     AND option_text = 'You focus only on what you are good at, because that feels safest and most concrete.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Courage to act' LIMIT 1), 0);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Mapping your inner world – You have 2 minutes to reflect: What do you love, what are you good at, what does the world need, and what can you be paid for? Which area is easiest for you to define?' ORDER BY id DESC LIMIT 1), 'You start with what you love, and let that pull you toward the other three dimensions.', 'Strong start. Passion is a powerful entry point into the IKIGAI model. When you know what energises you, the other quadrants become easier to explore honestly.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Mapping your inner world – You have 2 minutes to reflect: What do you love, what are you good at, what does the world need, and what can you be paid for? Which area is easiest for you to define?') 
     AND option_text = 'You start with what you love, and let that pull you toward the other three dimensions.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Purpose clarity' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Mapping your inner world – You have 2 minutes to reflect: What do you love, what are you good at, what does the world need, and what can you be paid for? Which area is easiest for you to define?') 
     AND option_text = 'You start with what you love, and let that pull you toward the other three dimensions.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Alignment' LIMIT 1), 10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Mapping your inner world – You have 2 minutes to reflect: What do you love, what are you good at, what does the world need, and what can you be paid for? Which area is easiest for you to define?') 
     AND option_text = 'You start with what you love, and let that pull you toward the other three dimensions.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Courage to act' LIMIT 1), 10);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 1: Awareness' AND owner_id = (SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge') LIMIT 1), 'mcq', 3, LAST_INSERT_ID());

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge'), 2, 'Phase 2: Tension', 'Facing reality', 'A comfortable trap is still a trap. Noticing the discomfort is already a form of courage.', 'This question names the most common IKIGAI tension: a stable life that lacks meaning. It invites learners to face the comfortable trap honestly, rather than rationalising it or dismissing the feeling entirely.');

-- Component 1 for Card 1
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://images.unsplash.com/photo-1497032628192-86f99bcd76bc', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 2: Tension' AND owner_id = (SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge') LIMIT 1), 'image', 1, LAST_INSERT_ID());

-- Component 2 for Card 1
INSERT INTO component_text (content) VALUES ('The comfortable trap – Your current path gives you income and stability, but lacks meaning. Do you accept it or start exploring alternatives?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 2: Tension' AND owner_id = (SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 1
INSERT INTO component_mcq (question) VALUES ('The comfortable trap – Your current path gives you income and stability, but lacks meaning. Do you accept it or start exploring alternatives?');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'The comfortable trap – Your current path gives you income and stability, but lacks meaning. Do you accept it or start exploring alternatives?' ORDER BY id DESC LIMIT 1), 'You stay on your current path because the risks of change feel too high right now.', 'Stability is a real need, not a weakness. But if the discomfort keeps returning, it is worth asking: is this a temporary trade-off or a long-term pattern?');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'The comfortable trap – Your current path gives you income and stability, but lacks meaning. Do you accept it or start exploring alternatives?') 
     AND option_text = 'You stay on your current path because the risks of change feel too high right now.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Purpose clarity' LIMIT 1), -5);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'The comfortable trap – Your current path gives you income and stability, but lacks meaning. Do you accept it or start exploring alternatives?') 
     AND option_text = 'You stay on your current path because the risks of change feel too high right now.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Alignment' LIMIT 1), -10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'The comfortable trap – Your current path gives you income and stability, but lacks meaning. Do you accept it or start exploring alternatives?') 
     AND option_text = 'You stay on your current path because the risks of change feel too high right now.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Courage to act' LIMIT 1), -10);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'The comfortable trap – Your current path gives you income and stability, but lacks meaning. Do you accept it or start exploring alternatives?' ORDER BY id DESC LIMIT 1), 'You decide to explore alternatives in small ways — reading, conversations, a side project — without leaving your current path yet.', 'This is a wise and realistic move. Exploration does not require a dramatic leap. Small, consistent steps toward meaning can reshape a path over time.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'The comfortable trap – Your current path gives you income and stability, but lacks meaning. Do you accept it or start exploring alternatives?') 
     AND option_text = 'You decide to explore alternatives in small ways — reading, conversations, a side project — without leaving your current path yet.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Purpose clarity' LIMIT 1), 10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'The comfortable trap – Your current path gives you income and stability, but lacks meaning. Do you accept it or start exploring alternatives?') 
     AND option_text = 'You decide to explore alternatives in small ways — reading, conversations, a side project — without leaving your current path yet.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Alignment' LIMIT 1), 10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'The comfortable trap – Your current path gives you income and stability, but lacks meaning. Do you accept it or start exploring alternatives?') 
     AND option_text = 'You decide to explore alternatives in small ways — reading, conversations, a side project — without leaving your current path yet.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Courage to act' LIMIT 1), 15);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'The comfortable trap – Your current path gives you income and stability, but lacks meaning. Do you accept it or start exploring alternatives?' ORDER BY id DESC LIMIT 1), 'You ignore the discomfort and tell yourself that meaning is not something work should provide.', 'This is a common coping strategy, but it can quietly erode motivation and engagement over time. Purpose and income do not have to be opposites.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'The comfortable trap – Your current path gives you income and stability, but lacks meaning. Do you accept it or start exploring alternatives?') 
     AND option_text = 'You ignore the discomfort and tell yourself that meaning is not something work should provide.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Purpose clarity' LIMIT 1), -10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'The comfortable trap – Your current path gives you income and stability, but lacks meaning. Do you accept it or start exploring alternatives?') 
     AND option_text = 'You ignore the discomfort and tell yourself that meaning is not something work should provide.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Alignment' LIMIT 1), -15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'The comfortable trap – Your current path gives you income and stability, but lacks meaning. Do you accept it or start exploring alternatives?') 
     AND option_text = 'You ignore the discomfort and tell yourself that meaning is not something work should provide.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Courage to act' LIMIT 1), -5);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 2: Tension' AND owner_id = (SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge') LIMIT 1), 'mcq', 3, LAST_INSERT_ID());

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge'), 3, 'Phase 3: Conflict', 'Making a choice', 'Passion and security are not always opposites. The boldest moves are often the most carefully designed ones.', 'This question confronts the classic IKIGAI dilemma: passion versus security. It helps learners identify their relationship with risk and explore whether a binary choice is truly the only option.');

-- Component 1 for Card 2
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1DCqxyEroWrMz9SVB_9-GWdQRnpkOgA8p/view?usp=drive_link', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 3: Conflict' AND owner_id = (SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge') LIMIT 1), 'image', 1, LAST_INSERT_ID());

-- Component 2 for Card 2
INSERT INTO component_text (content) VALUES ('Passion versus security – A meaningful but uncertain opportunity appears. Do you prioritise passion or financial security?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 3: Conflict' AND owner_id = (SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 2
INSERT INTO component_mcq (question) VALUES ('Passion versus security – A meaningful but uncertain opportunity appears. Do you prioritise passion or financial security?');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Passion versus security – A meaningful but uncertain opportunity appears. Do you prioritise passion or financial security?' ORDER BY id DESC LIMIT 1), 'You pursue the meaningful opportunity, accepting that income may be uncertain for a period.', 'Bold and values-aligned. This requires courage and realistic planning. Make sure you have a concrete support strategy so that uncertainty does not become a crisis.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Passion versus security – A meaningful but uncertain opportunity appears. Do you prioritise passion or financial security?') 
     AND option_text = 'You pursue the meaningful opportunity, accepting that income may be uncertain for a period.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Purpose clarity' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Passion versus security – A meaningful but uncertain opportunity appears. Do you prioritise passion or financial security?') 
     AND option_text = 'You pursue the meaningful opportunity, accepting that income may be uncertain for a period.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Alignment' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Passion versus security – A meaningful but uncertain opportunity appears. Do you prioritise passion or financial security?') 
     AND option_text = 'You pursue the meaningful opportunity, accepting that income may be uncertain for a period.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Courage to act' LIMIT 1), 20);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Passion versus security – A meaningful but uncertain opportunity appears. Do you prioritise passion or financial security?' ORDER BY id DESC LIMIT 1), 'You decline and stay where you are, deciding financial security must come first.', 'This is a legitimate choice. Security matters. The question worth sitting with is: are you choosing stability as a foundation to build from, or as a way to avoid the risk of meaning?');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Passion versus security – A meaningful but uncertain opportunity appears. Do you prioritise passion or financial security?') 
     AND option_text = 'You decline and stay where you are, deciding financial security must come first.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Purpose clarity' LIMIT 1), -5);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Passion versus security – A meaningful but uncertain opportunity appears. Do you prioritise passion or financial security?') 
     AND option_text = 'You decline and stay where you are, deciding financial security must come first.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Alignment' LIMIT 1), -10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Passion versus security – A meaningful but uncertain opportunity appears. Do you prioritise passion or financial security?') 
     AND option_text = 'You decline and stay where you are, deciding financial security must come first.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Courage to act' LIMIT 1), -10);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Passion versus security – A meaningful but uncertain opportunity appears. Do you prioritise passion or financial security?' ORDER BY id DESC LIMIT 1), 'You explore whether it is possible to design a transition - reducing the financial risk while moving gradually toward the meaningful path.', 'Excellent. This reframes the either/or into a both/and. A phased transition often protects both financial stability and long-term alignment. This is strategic courage.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Passion versus security – A meaningful but uncertain opportunity appears. Do you prioritise passion or financial security?') 
     AND option_text = 'You explore whether it is possible to design a transition - reducing the financial risk while moving gradually toward the meaningful path.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Purpose clarity' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Passion versus security – A meaningful but uncertain opportunity appears. Do you prioritise passion or financial security?') 
     AND option_text = 'You explore whether it is possible to design a transition - reducing the financial risk while moving gradually toward the meaningful path.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Alignment' LIMIT 1), 20);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Passion versus security – A meaningful but uncertain opportunity appears. Do you prioritise passion or financial security?') 
     AND option_text = 'You explore whether it is possible to design a transition - reducing the financial risk while moving gradually toward the meaningful path.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Courage to act' LIMIT 1), 15);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 3: Conflict' AND owner_id = (SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge') LIMIT 1), 'mcq', 3, LAST_INSERT_ID());

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge'), 4, 'Phase 4: Reflection', 'Regaining clarity', 'You do not need to have all four circles full to move forward. Knowing which one is emptiest is already meaningful clarity.', 'This reflection card helps learners name which IKIGAI dimension needs the most attention. It supports personalised learning and reminds them that clarity is built from honest self-assessment, not from getting everything right at once.');

-- Component 1 for Card 3
INSERT INTO component_video (video_url, video_alt, video_description) VALUES ('https://www.youtube.com/watch?v=pk-PcJS2QaU', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 4: Reflection' AND owner_id = (SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge') LIMIT 1), 'video', 1, LAST_INSERT_ID());

-- Component 2 for Card 3
INSERT INTO component_text (content) VALUES ('Pause and Reconnect – Take a step back. Which IKIGAI element is missing most in your life right now?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 4: Reflection' AND owner_id = (SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 3
INSERT INTO component_mcq (question) VALUES ('Pause and Reconnect – Take a step back. Which IKIGAI element is missing most in your life right now?');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Pause and Reconnect – Take a step back. Which IKIGAI element is missing most in your life right now?' ORDER BY id DESC LIMIT 1), 'You identify that what the world needs is the element most missing - you are skilled and paid, but your work feels disconnected from any larger purpose.', 'An honest and important insight. Contribution is often the bridge between competence and meaning. Consider: what problem would you genuinely love to be part of solving?');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Pause and Reconnect – Take a step back. Which IKIGAI element is missing most in your life right now?') 
     AND option_text = 'You identify that what the world needs is the element most missing - you are skilled and paid, but your work feels disconnected from any larger purpose.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Purpose clarity' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Pause and Reconnect – Take a step back. Which IKIGAI element is missing most in your life right now?') 
     AND option_text = 'You identify that what the world needs is the element most missing - you are skilled and paid, but your work feels disconnected from any larger purpose.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Alignment' LIMIT 1), 10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Pause and Reconnect – Take a step back. Which IKIGAI element is missing most in your life right now?') 
     AND option_text = 'You identify that what the world needs is the element most missing - you are skilled and paid, but your work feels disconnected from any larger purpose.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Courage to act' LIMIT 1), 10);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Pause and Reconnect – Take a step back. Which IKIGAI element is missing most in your life right now?' ORDER BY id DESC LIMIT 1), 'You realise that passion is missing — you are capable and needed, but you no longer feel energised by the work itself.', 'This takes self-awareness. Passion does not mean excitement every day, but chronic absence of energy is worth examining. What activities used to energise you that your current work no longer includes?');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Pause and Reconnect – Take a step back. Which IKIGAI element is missing most in your life right now?') 
     AND option_text = 'You realise that passion is missing — you are capable and needed, but you no longer feel energised by the work itself.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Purpose clarity' LIMIT 1), 10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Pause and Reconnect – Take a step back. Which IKIGAI element is missing most in your life right now?') 
     AND option_text = 'You realise that passion is missing — you are capable and needed, but you no longer feel energised by the work itself.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Alignment' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Pause and Reconnect – Take a step back. Which IKIGAI element is missing most in your life right now?') 
     AND option_text = 'You realise that passion is missing — you are capable and needed, but you no longer feel energised by the work itself.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Courage to act' LIMIT 1), 5);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Pause and Reconnect – Take a step back. Which IKIGAI element is missing most in your life right now?' ORDER BY id DESC LIMIT 1), 'You feel so unclear about all four areas that you struggle to identify which one is most missing.', 'That is also a valid and honest answer. Confusion is not failure - it often signals that a deeper reset is needed before direction becomes clear. Consider starting with a trusted person rather than a framework.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Pause and Reconnect – Take a step back. Which IKIGAI element is missing most in your life right now?') 
     AND option_text = 'You feel so unclear about all four areas that you struggle to identify which one is most missing.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Purpose clarity' LIMIT 1), 5);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Pause and Reconnect – Take a step back. Which IKIGAI element is missing most in your life right now?') 
     AND option_text = 'You feel so unclear about all four areas that you struggle to identify which one is most missing.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Alignment' LIMIT 1), 5);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Pause and Reconnect – Take a step back. Which IKIGAI element is missing most in your life right now?') 
     AND option_text = 'You feel so unclear about all four areas that you struggle to identify which one is most missing.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Courage to act' LIMIT 1), 10);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 4: Reflection' AND owner_id = (SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge') LIMIT 1), 'mcq', 3, LAST_INSERT_ID());

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge'), 5, 'Phase 5: Action', 'Outcome & alignment', 'You have completed the IKIGAI simulator. Your result reflects where you stand today in your relationship with purpose, alignment, and courage. IKIGAI is not a destination - it is a direction. Keep moving toward it, one small step at a time.', 'This final card closes the simulator with commitment. It supports the transfer of insight into real-world action, which is the ultimate goal of IKIGAI work. The learner practises choosing a concrete next step rather than leaving with only ideas.');

-- Component 1 for Card 4
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://images.unsplash.com/photo-1500530855697-b586d89ba3ee', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 5: Action' AND owner_id = (SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge') LIMIT 1), 'image', 1, LAST_INSERT_ID());

-- Component 2 for Card 4
INSERT INTO component_text (content) VALUES ('Designing your path – You now see your gaps. What is one concrete action you commit to this week to move closer to your IKIGAI?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 5: Action' AND owner_id = (SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 4
INSERT INTO component_mcq (question) VALUES ('Designing your path – You now see your gaps. What is one concrete action you commit to this week to move closer to your IKIGAI?');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Designing your path – You now see your gaps. What is one concrete action you commit to this week to move closer to your IKIGAI?' ORDER BY id DESC LIMIT 1), 'You commit to a specific, small action this week (such as having one conversation, trying one task, or researching one path) that moves you toward your IKIGAI.', 'Excellent. Specificity transforms intention into momentum. A concrete next step. however small , is more powerful than a large plan with no first move.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Designing your path – You now see your gaps. What is one concrete action you commit to this week to move closer to your IKIGAI?') 
     AND option_text = 'You commit to a specific, small action this week (such as having one conversation, trying one task, or researching one path) that moves you toward your IKIGAI.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Purpose clarity' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Designing your path – You now see your gaps. What is one concrete action you commit to this week to move closer to your IKIGAI?') 
     AND option_text = 'You commit to a specific, small action this week (such as having one conversation, trying one task, or researching one path) that moves you toward your IKIGAI.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Alignment' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Designing your path – You now see your gaps. What is one concrete action you commit to this week to move closer to your IKIGAI?') 
     AND option_text = 'You commit to a specific, small action this week (such as having one conversation, trying one task, or researching one path) that moves you toward your IKIGAI.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Courage to act' LIMIT 1), 20);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Designing your path – You now see your gaps. What is one concrete action you commit to this week to move closer to your IKIGAI?' ORDER BY id DESC LIMIT 1), 'You decide to think more before acting - you want to be sure before you commit to anything.', 'Reflection has value, but ongoing thinking without action can become a way of staying safe. At some point, a small step teaches you more than any amount of planning.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Designing your path – You now see your gaps. What is one concrete action you commit to this week to move closer to your IKIGAI?') 
     AND option_text = 'You decide to think more before acting - you want to be sure before you commit to anything.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Purpose clarity' LIMIT 1), 5);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Designing your path – You now see your gaps. What is one concrete action you commit to this week to move closer to your IKIGAI?') 
     AND option_text = 'You decide to think more before acting - you want to be sure before you commit to anything.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Alignment' LIMIT 1), 0);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Designing your path – You now see your gaps. What is one concrete action you commit to this week to move closer to your IKIGAI?') 
     AND option_text = 'You decide to think more before acting - you want to be sure before you commit to anything.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Courage to act' LIMIT 1), -10);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Designing your path – You now see your gaps. What is one concrete action you commit to this week to move closer to your IKIGAI?' ORDER BY id DESC LIMIT 1), 'You share your IKIGAI insights with someone you trust and ask for their perspective or accountability.', 'Strong choice. Speaking your intention out loud builds commitment. An external perspective can also reveal blind spots that are invisible from the inside.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Designing your path – You now see your gaps. What is one concrete action you commit to this week to move closer to your IKIGAI?') 
     AND option_text = 'You share your IKIGAI insights with someone you trust and ask for their perspective or accountability.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Purpose clarity' LIMIT 1), 10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Designing your path – You now see your gaps. What is one concrete action you commit to this week to move closer to your IKIGAI?') 
     AND option_text = 'You share your IKIGAI insights with someone you trust and ask for their perspective or accountability.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Alignment' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Designing your path – You now see your gaps. What is one concrete action you commit to this week to move closer to your IKIGAI?') 
     AND option_text = 'You share your IKIGAI insights with someone you trust and ask for their perspective or accountability.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Courage to act' LIMIT 1), 15);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Phase 5: Action' AND owner_id = (SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge') LIMIT 1), 'mcq', 3, LAST_INSERT_ID());

-- ============================================
-- Feedback Tiers
-- ============================================

-- Feedback for metric 'Purpose clarity' (Score 0-49)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge'), (SELECT id FROM simulator_metric WHERE name = 'Purpose clarity' LIMIT 1), 0, 49, 'You are beginning to explore what truly matters to you.', 'You feel unsure about your direction and rely on external expectations.', 'Write down 3 moments when you felt truly fulfilled and identify common themes.', NULL, 'When purpose clarity is low, the most valuable first step is turning inward before looking outward. This module helps you reconnect with what has genuinely mattered to you in the past, identify patterns in your energy and motivation, and begin building a personal sense of direction that is not borrowed from others'' expectations.');

-- Feedback for metric 'Purpose clarity' (Score 50-85)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge'), (SELECT id FROM simulator_metric WHERE name = 'Purpose clarity' LIMIT 1), 50, 85, 'You have a growing understanding of your passions and strengths.', 'Your direction is not yet fully consistent across life areas.', 'Define your top 3 values and use them to guide one decision this week.', NULL, 'You already have a working sense of what drives you — the next step is making that direction more deliberate and consistent. This module helps you translate emerging self-knowledge into clearer decisions, more intentional communication, and a leadership identity that reflects who you are becoming, not just what you have done so far.');

-- Feedback for metric 'Purpose clarity' (Score 85-100)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge'), (SELECT id FROM simulator_metric WHERE name = 'Purpose clarity' LIMIT 1), 85, 100, 'You have a clear and grounded sense of purpose.', 'None. Your direction is internally driven and stable.', 'Share and test your purpose with others to refine it further.', NULL, 'A well-defined sense of purpose becomes most powerful when it is tested, shared, and applied to real choices. This module helps you use your clarity as a foundation for influencing others, navigating complexity, and making purpose-led decisions under pressure — so that your direction strengthens rather than fades in demanding conditions.');

-- Feedback for metric 'Alignment' (Score 0-49)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge'), (SELECT id FROM simulator_metric WHERE name = 'Alignment' LIMIT 1), 0, 49, 'You are aware that something feels misaligned.', 'Your daily actions do not reflect what truly matters to you.', 'At the end of each day, ask: “Did I act in line with my values?”', NULL, 'When daily life feels disconnected from what matters, the gap is rarely about knowing what to do — it is about the habits, patterns, and commitments that have built up over time. This module helps you examine where your energy is going, identify what is misaligned, and begin making small but deliberate adjustments that bring your actions closer to your values.');

-- Feedback for metric 'Alignment' (Score 50-85)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge'), (SELECT id FROM simulator_metric WHERE name = 'Alignment' LIMIT 1), 50, 85, 'You are partially aligned with your IKIGAI.', 'Some parts of your life still feel forced or draining.', 'Identify one misaligned activity and adjust or replace it this week.', NULL, 'Partial alignment often means you have made progress in some areas of life but not yet in others. This module helps you look at the full picture — work, relationships, daily choices — and strengthen the connection between your values and your behaviour in the areas where the gap is still noticeable. The goal is consistency, not perfection.');

-- Feedback for metric 'Alignment' (Score 85-100)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge'), (SELECT id FROM simulator_metric WHERE name = 'Alignment' LIMIT 1), 85, 100, 'Your actions strongly reflect your purpose.', 'None. You consistently live in alignment.', 'Support someone else in identifying where they feel misaligned.', NULL, 'When you live and act in alignment with your values, you become a visible example of what purposeful leadership looks like. This module helps you deepen that practice and extend it — by creating conditions where the people around you can also find greater alignment between their work and what matters to them.');

-- Feedback for metric 'Courage to act' (Score 0-49)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge'), (SELECT id FROM simulator_metric WHERE name = 'Courage to act' LIMIT 1), 0, 49, 'You carefully think through decisions.', 'Fear of uncertainty keeps you in safe but unfulfilling situations.', 'Take one small step this week toward something meaningful but uncertain.', NULL, 'Hesitation in the face of uncertainty is one of the most common reasons people stay stuck in paths that no longer serve them. This module helps you understand the roots of that hesitation, distinguish between useful caution and fear-driven avoidance, and practise taking small, concrete steps that build the evidence that action is survivable — and often transformative.');

-- Feedback for metric 'Courage to act' (Score 50-85)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge'), (SELECT id FROM simulator_metric WHERE name = 'Courage to act' LIMIT 1), 50, 85, 'You are willing to step outside your comfort zone.', 'You still hesitate when the stakes feel high.', 'Make one decision faster than usual, trusting your intuition.', NULL, 'You are already capable of stepping outside your comfort zone — the challenge is doing it consistently when the stakes feel higher than usual. This module helps you develop a more reliable relationship with uncertainty: recognising when hesitation is protecting you and when it is holding you back, and building the decision-making habits that allow you to act with more confidence and less second-guessing.');

-- Feedback for metric 'Courage to act' (Score 85-100)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Find your IKIGAI: Purpose discovering challenge'), (SELECT id FROM simulator_metric WHERE name = 'Courage to act' LIMIT 1), 85, 100, 'You confidently take action aligned with your purpose.', 'None. You act despite uncertainty.', 'Reflect on a bold decision and define your personal decision-making rule.', NULL, 'Acting with purpose despite uncertainty is one of the rarest and most valuable leadership capacities. This module helps you refine and articulate your personal approach to bold decisions — so that you can not only continue acting with courage yourself, but also help others around you develop the same ability when it matters most.');

-- ============================================
-- End of generated queries
-- ============================================
