-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:10.841456
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Simulator: The Meeting That Changed Your Narrative
-- ============================================
INSERT INTO simulator (title, description, level, localisation, estimated_duration, created_at) VALUES ('The Meeting That Changed Your Narrative', 'No description', 'core', 'work', 0, '2026-08-23 19:54:10.840699');

-- Simulator Tags
INSERT INTO simulator_tag (name) VALUES ('self-confidence');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative'), (SELECT id FROM simulator_tag WHERE name = 'self-confidence' LIMIT 1));
INSERT INTO simulator_tag (name) VALUES ('leadership');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative'), (SELECT id FROM simulator_tag WHERE name = 'leadership' LIMIT 1));
INSERT INTO simulator_tag (name) VALUES ('imposter syndrome');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative'), (SELECT id FROM simulator_tag WHERE name = 'imposter syndrome' LIMIT 1));
INSERT INTO simulator_tag (name) VALUES ('communication');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative'), (SELECT id FROM simulator_tag WHERE name = 'communication' LIMIT 1));
INSERT INTO simulator_tag (name) VALUES ('resilience');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative'), (SELECT id FROM simulator_tag WHERE name = 'resilience' LIMIT 1));
INSERT INTO simulator_tag (name) VALUES ('women empowerment');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative'), (SELECT id FROM simulator_tag WHERE name = 'women empowerment' LIMIT 1));

-- Simulator Metrics
INSERT INTO simulator_metric (name) VALUES ('Self-Trust');
INSERT INTO simulator_contains_metric (simulator_id, metric_id) VALUES ((SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative'), (SELECT id FROM simulator_metric WHERE name = 'Self-Trust' LIMIT 1));
INSERT INTO simulator_metric (name) VALUES ('Assertive Communication');
INSERT INTO simulator_contains_metric (simulator_id, metric_id) VALUES ((SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative'), (SELECT id FROM simulator_metric WHERE name = 'Assertive Communication' LIMIT 1));
INSERT INTO simulator_metric (name) VALUES ('Narrative Awareness');
INSERT INTO simulator_contains_metric (simulator_id, metric_id) VALUES ((SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative'), (SELECT id FROM simulator_metric WHERE name = 'Narrative Awareness' LIMIT 1));
INSERT INTO simulator_metric (name) VALUES ('Resilience');
INSERT INTO simulator_contains_metric (simulator_id, metric_id) VALUES ((SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative'), (SELECT id FROM simulator_metric WHERE name = 'Resilience' LIMIT 1));

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative'), 1, 'The Invitation', 'A new opportunity appears', 'The stories we repeat internally often shape the opportunities we allow ourselves to take.', 'Many women internalize the idea that they must feel “fully ready” before taking visible opportunities.');

-- Component 1 for Card 0
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('A young professional woman reading an email on her laptop, looking uncertain but thoughtful in a modern office.', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The Invitation' AND owner_id = (SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative') LIMIT 1), 'image', 1, LAST_INSERT_ID());

-- Component 2 for Card 0
INSERT INTO component_text (content) VALUES ('Your manager invites you to present your team’s work during a leadership meeting next week. Your first reaction is panic. A voice in your head says: “There are probably more qualified people for this.”');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The Invitation' AND owner_id = (SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 0
INSERT INTO component_mcq (question) VALUES ('Your manager invites you to present your team’s work during a leadership meeting next week. Your first reaction is panic. A voice in your head says: “There are probably more qualified people for this.”');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Your manager invites you to present your team’s work during a leadership meeting next week. Your first reaction is panic. A voice in your head says: “There are probably more qualified people for this.”' ORDER BY id DESC LIMIT 1), 'Accept immediately and begin preparing key talking points', 'You recognize that discomfort does not mean incapability. By stepping forward, you interrupt an old limiting narrative.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Your manager invites you to present your team’s work during a leadership meeting next week. Your first reaction is panic. A voice in your head says: “There are probably more qualified people for this.”') 
     AND option_text = 'Accept immediately and begin preparing key talking points' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-Trust' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Your manager invites you to present your team’s work during a leadership meeting next week. Your first reaction is panic. A voice in your head says: “There are probably more qualified people for this.”') 
     AND option_text = 'Accept immediately and begin preparing key talking points' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Resilience' LIMIT 1), 10);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Your manager invites you to present your team’s work during a leadership meeting next week. Your first reaction is panic. A voice in your head says: “There are probably more qualified people for this.”' ORDER BY id DESC LIMIT 1), 'Ask if someone more experienced can present with you.', 'Seeking support can be healthy, but in this moment it partly reinforces the belief that you cannot handle visibility alone');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Your manager invites you to present your team’s work during a leadership meeting next week. Your first reaction is panic. A voice in your head says: “There are probably more qualified people for this.”') 
     AND option_text = 'Ask if someone more experienced can present with you.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-Trust' LIMIT 1), -5);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'Your manager invites you to present your team’s work during a leadership meeting next week. Your first reaction is panic. A voice in your head says: “There are probably more qualified people for this.”' ORDER BY id DESC LIMIT 1), 'Decline politely and say you are too busy.', 'Avoidance protects you from short-term discomfort, but strengthens the story that your voice should stay small.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Your manager invites you to present your team’s work during a leadership meeting next week. Your first reaction is panic. A voice in your head says: “There are probably more qualified people for this.”') 
     AND option_text = 'Decline politely and say you are too busy.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-Trust' LIMIT 1), -15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'Your manager invites you to present your team’s work during a leadership meeting next week. Your first reaction is panic. A voice in your head says: “There are probably more qualified people for this.”') 
     AND option_text = 'Decline politely and say you are too busy.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Resilience' LIMIT 1), -10);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The Invitation' AND owner_id = (SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative') LIMIT 1), 'mcq', 3, LAST_INSERT_ID());

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative'), 2, 'The Inner Critic', 'Your narrative becomes louder', 'Awareness is the first step toward rewriting a story.', 'Limiting narratives often come from isolated moments that become exaggerated over time.');

-- Component 1 for Card 1
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('A woman sitting at a desk surrounded by notes, looking reflective while remembering a past experience.', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The Inner Critic' AND owner_id = (SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative') LIMIT 1), 'image', 1, LAST_INSERT_ID());

-- Component 2 for Card 1
INSERT INTO component_text (content) VALUES ('While preparing for the presentation, you remember a time years ago when someone interrupted you during a class presentation. Suddenly you begin thinking: “I always sound nervous when I speak.”');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The Inner Critic' AND owner_id = (SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 1
INSERT INTO component_mcq (question) VALUES ('While preparing for the presentation, you remember a time years ago when someone interrupted you during a class presentation. Suddenly you begin thinking: “I always sound nervous when I speak.”');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'While preparing for the presentation, you remember a time years ago when someone interrupted you during a class presentation. Suddenly you begin thinking: “I always sound nervous when I speak.”' ORDER BY id DESC LIMIT 1), 'Pause and ask yourself whether this thought is actually factual or simply familiar.', 'You practice narrative awareness by separating old emotional memories from present reality.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'While preparing for the presentation, you remember a time years ago when someone interrupted you during a class presentation. Suddenly you begin thinking: “I always sound nervous when I speak.”') 
     AND option_text = 'Pause and ask yourself whether this thought is actually factual or simply familiar.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Narrative Awareness' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'While preparing for the presentation, you remember a time years ago when someone interrupted you during a class presentation. Suddenly you begin thinking: “I always sound nervous when I speak.”') 
     AND option_text = 'Pause and ask yourself whether this thought is actually factual or simply familiar.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-Trust' LIMIT 1), 10);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'While preparing for the presentation, you remember a time years ago when someone interrupted you during a class presentation. Suddenly you begin thinking: “I always sound nervous when I speak.”' ORDER BY id DESC LIMIT 1), 'Ignore the thought and continue working without reflecting on it.', 'Pushing thoughts away may help temporarily, but it does not challenge the underlying narrative.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'While preparing for the presentation, you remember a time years ago when someone interrupted you during a class presentation. Suddenly you begin thinking: “I always sound nervous when I speak.”') 
     AND option_text = 'Ignore the thought and continue working without reflecting on it.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Narrative Awareness' LIMIT 1), 0);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'While preparing for the presentation, you remember a time years ago when someone interrupted you during a class presentation. Suddenly you begin thinking: “I always sound nervous when I speak.”' ORDER BY id DESC LIMIT 1), 'Replay the embarrassing memory repeatedly and criticize yourself for it.', 'Repetition strengthens limiting beliefs, even when they are outdated or incomplete.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'While preparing for the presentation, you remember a time years ago when someone interrupted you during a class presentation. Suddenly you begin thinking: “I always sound nervous when I speak.”') 
     AND option_text = 'Replay the embarrassing memory repeatedly and criticize yourself for it.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Narrative Awareness' LIMIT 1), -15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'While preparing for the presentation, you remember a time years ago when someone interrupted you during a class presentation. Suddenly you begin thinking: “I always sound nervous when I speak.”') 
     AND option_text = 'Replay the embarrassing memory repeatedly and criticize yourself for it.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-Trust' LIMIT 1), -10);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The Inner Critic' AND owner_id = (SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative') LIMIT 1), 'mcq', 3, LAST_INSERT_ID());

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative'), 3, 'Rewriting the Story', 'You choose a new interpretation', 'The meaning you attach to experiences shapes your confidence more than the experiences themselves.', 'Empowerment does not mean avoiding feedback; it means interpreting feedback without collapsing into self-doubt.');

-- Component 1 for Card 2
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('Two colleagues reviewing a presentation together in a collaborative workspace.', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Rewriting the Story' AND owner_id = (SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative') LIMIT 1), 'image', 1, LAST_INSERT_ID());

-- Component 2 for Card 2
INSERT INTO component_text (content) VALUES ('A colleague reviews your draft presentation and says: “This is strong, but you could speak even more confidently.” You feel defensive and embarrassed.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Rewriting the Story' AND owner_id = (SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 2
INSERT INTO component_mcq (question) VALUES ('A colleague reviews your draft presentation and says: “This is strong, but you could speak even more confidently.” You feel defensive and embarrassed.');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'A colleague reviews your draft presentation and says: “This is strong, but you could speak even more confidently.” You feel defensive and embarrassed.' ORDER BY id DESC LIMIT 1), 'Reframe the feedback as support for your growth instead of proof that you are failing.', 'You shift from shame to learning. Empowering narratives leave room for development without attacking identity.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'A colleague reviews your draft presentation and says: “This is strong, but you could speak even more confidently.” You feel defensive and embarrassed.') 
     AND option_text = 'Reframe the feedback as support for your growth instead of proof that you are failing.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Resilience' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'A colleague reviews your draft presentation and says: “This is strong, but you could speak even more confidently.” You feel defensive and embarrassed.') 
     AND option_text = 'Reframe the feedback as support for your growth instead of proof that you are failing.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Narrative Awareness' LIMIT 1), 10);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'A colleague reviews your draft presentation and says: “This is strong, but you could speak even more confidently.” You feel defensive and embarrassed.' ORDER BY id DESC LIMIT 1), 'Thank them politely but secretly decide you are not good at public speaking.', 'Outwardly staying calm while internally reinforcing self-doubt keeps the limiting narrative alive.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'A colleague reviews your draft presentation and says: “This is strong, but you could speak even more confidently.” You feel defensive and embarrassed.') 
     AND option_text = 'Thank them politely but secretly decide you are not good at public speaking.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-Trust' LIMIT 1), -10);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'A colleague reviews your draft presentation and says: “This is strong, but you could speak even more confidently.” You feel defensive and embarrassed.' ORDER BY id DESC LIMIT 1), 'Become defensive and stop asking for feedback entirely.', 'Protecting yourself from discomfort can reduce growth opportunities and reinforce fear of judgment.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'A colleague reviews your draft presentation and says: “This is strong, but you could speak even more confidently.” You feel defensive and embarrassed.') 
     AND option_text = 'Become defensive and stop asking for feedback entirely.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Assertive Communication' LIMIT 1), -10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'A colleague reviews your draft presentation and says: “This is strong, but you could speak even more confidently.” You feel defensive and embarrassed.') 
     AND option_text = 'Become defensive and stop asking for feedback entirely.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Resilience' LIMIT 1), -10);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Rewriting the Story' AND owner_id = (SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative') LIMIT 1), 'mcq', 3, LAST_INSERT_ID());

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative'), 4, 'The Meeting', 'Your moment arrives', 'Assertiveness is not dominance. It is self-respect expressed clearly.', 'Women are often socially conditioned to minimize themselves in group settings.');

-- Component 1 for Card 3
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('A conference room with several professionals seated around a table while one woman presents confidently.', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The Meeting' AND owner_id = (SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative') LIMIT 1), 'image', 1, LAST_INSERT_ID());

-- Component 2 for Card 3
INSERT INTO component_text (content) VALUES ('During the leadership meeting, someone interrupts you halfway through your explanation. The room goes quiet for a moment.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The Meeting' AND owner_id = (SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 3
INSERT INTO component_mcq (question) VALUES ('During the leadership meeting, someone interrupts you halfway through your explanation. The room goes quiet for a moment.');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'During the leadership meeting, someone interrupts you halfway through your explanation. The room goes quiet for a moment.' ORDER BY id DESC LIMIT 1), 'Calmly continue speaking and say: “I’d like to finish my point first.”', 'You communicate assertively without aggression and reinforce the belief that your voice deserves space.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'During the leadership meeting, someone interrupts you halfway through your explanation. The room goes quiet for a moment.') 
     AND option_text = 'Calmly continue speaking and say: “I’d like to finish my point first.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Assertive Communication' LIMIT 1), 20);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'During the leadership meeting, someone interrupts you halfway through your explanation. The room goes quiet for a moment.') 
     AND option_text = 'Calmly continue speaking and say: “I’d like to finish my point first.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-Trust' LIMIT 1), 10);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'During the leadership meeting, someone interrupts you halfway through your explanation. The room goes quiet for a moment.' ORDER BY id DESC LIMIT 1), 'Stop speaking and let the interruption take over the conversation.', 'Staying silent may feel safer in the moment, but it can reinforce patterns of self-erasure');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'During the leadership meeting, someone interrupts you halfway through your explanation. The room goes quiet for a moment.') 
     AND option_text = 'Stop speaking and let the interruption take over the conversation.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Assertive Communication' LIMIT 1), -15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'During the leadership meeting, someone interrupts you halfway through your explanation. The room goes quiet for a moment.') 
     AND option_text = 'Stop speaking and let the interruption take over the conversation.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-Trust' LIMIT 1), -10);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'During the leadership meeting, someone interrupts you halfway through your explanation. The room goes quiet for a moment.' ORDER BY id DESC LIMIT 1), 'Apologize repeatedly before continuing.', 'Over-apologizing can unintentionally communicate uncertainty, even when your contribution is valuable.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'During the leadership meeting, someone interrupts you halfway through your explanation. The room goes quiet for a moment.') 
     AND option_text = 'Apologize repeatedly before continuing.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Assertive Communication' LIMIT 1), -5);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'During the leadership meeting, someone interrupts you halfway through your explanation. The room goes quiet for a moment.') 
     AND option_text = 'Apologize repeatedly before continuing.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Narrative Awareness' LIMIT 1), 5);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The Meeting' AND owner_id = (SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative') LIMIT 1), 'mcq', 3, LAST_INSERT_ID());

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative'), 5, 'Your New Narrative', 'You reflect on the experience', 'Your narrative is built one interpretation at a time.', 'Empowerment grows when achievements become part of your self-story instead of being dismissed.');

-- Component 1 for Card 4
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('A woman walking confidently through a city after work, reflecting with calm determination.', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your New Narrative' AND owner_id = (SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative') LIMIT 1), 'image', 1, LAST_INSERT_ID());

-- Component 2 for Card 4
INSERT INTO component_text (content) VALUES ('After the meeting, you realize you handled a situation that once would have intimidated you. You now have a chance to define what this experience means about you.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your New Narrative' AND owner_id = (SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 4
INSERT INTO component_mcq (question) VALUES ('After the meeting, you realize you handled a situation that once would have intimidated you. You now have a chance to define what this experience means about you.');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'After the meeting, you realize you handled a situation that once would have intimidated you. You now have a chance to define what this experience means about you.' ORDER BY id DESC LIMIT 1), 'Write down three strengths you demonstrated during the experience.', 'Naming your strengths helps transform isolated successes into a lasting empowering narrative.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'After the meeting, you realize you handled a situation that once would have intimidated you. You now have a chance to define what this experience means about you.') 
     AND option_text = 'Write down three strengths you demonstrated during the experience.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-Trust' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'After the meeting, you realize you handled a situation that once would have intimidated you. You now have a chance to define what this experience means about you.') 
     AND option_text = 'Write down three strengths you demonstrated during the experience.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Narrative Awareness' LIMIT 1), 10);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'After the meeting, you realize you handled a situation that once would have intimidated you. You now have a chance to define what this experience means about you.' ORDER BY id DESC LIMIT 1), 'Focus only on the mistakes you made during the presentation.', 'Perfection-focused thinking can erase evidence of growth and resilience');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'After the meeting, you realize you handled a situation that once would have intimidated you. You now have a chance to define what this experience means about you.') 
     AND option_text = 'Focus only on the mistakes you made during the presentation.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-Trust' LIMIT 1), -10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'After the meeting, you realize you handled a situation that once would have intimidated you. You now have a chance to define what this experience means about you.') 
     AND option_text = 'Focus only on the mistakes you made during the presentation.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Resilience' LIMIT 1), -5);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'After the meeting, you realize you handled a situation that once would have intimidated you. You now have a chance to define what this experience means about you.' ORDER BY id DESC LIMIT 1), 'Tell yourself you simply “got lucky.”', 'Minimizing success prevents confidence from becoming integrated into your identity.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'After the meeting, you realize you handled a situation that once would have intimidated you. You now have a chance to define what this experience means about you.') 
     AND option_text = 'Tell yourself you simply “got lucky.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Self-Trust' LIMIT 1), -15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'After the meeting, you realize you handled a situation that once would have intimidated you. You now have a chance to define what this experience means about you.') 
     AND option_text = 'Tell yourself you simply “got lucky.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Narrative Awareness' LIMIT 1), -10);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your New Narrative' AND owner_id = (SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative') LIMIT 1), 'mcq', 3, LAST_INSERT_ID());

-- ============================================
-- Feedback Tiers
-- ============================================

-- Feedback for metric 'Self-Trust' (Score 0-49)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative'), (SELECT id FROM simulator_metric WHERE name = 'Self-Trust' LIMIT 1), 0, 49, 'You may still rely heavily on external validation before trusting your own abilities.', 'Self-doubt can lead you to avoid visibility and underestimate your strengths.', 'Every evening, write down one decision you handled well that day.', NULL, 'This module helps participants strengthen confidence and recognize their own capabilities more clearly.');

-- Feedback for metric 'Assertive Communication' (Score 0-49)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative'), (SELECT id FROM simulator_metric WHERE name = 'Assertive Communication' LIMIT 1), 0, 49, 'You may hesitate to express your needs or hold space for your voice.', 'Others may unintentionally dominate conversations when boundaries are unclear.', 'Practice saying one clear opinion in meetings without apologizing first.', NULL, 'This module helps participants communicate more clearly and confidently in visible situations.');

-- Feedback for metric 'Narrative Awareness' (Score 0-49)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative'), (SELECT id FROM simulator_metric WHERE name = 'Narrative Awareness' LIMIT 1), 0, 49, 'You may accept limiting thoughts as objective truth instead of learned stories.', 'Old narratives can quietly shape your decisions and confidence levels.', 'Write down one recurring negative belief and ask: “Where did I learn this?”', NULL, 'This module encourages participants to better understand themselves and recognize hidden inner strengths.');

-- Feedback for metric 'Resilience' (Score 0-49)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'The Meeting That Changed Your Narrative'), (SELECT id FROM simulator_metric WHERE name = 'Resilience' LIMIT 1), 0, 49, 'Difficult feedback or setbacks may strongly affect your confidence.', 'Fear of failure can lead to avoidance and self-protection behaviors.', 'After setbacks, write one thing the experience taught you.', NULL, 'This module helps participants build healthier recovery habits and emotional resilience.');

-- ============================================
-- End of generated queries
-- ============================================
