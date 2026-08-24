-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:10.824653
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Simulator: Your Voice, Your Space
-- ============================================
INSERT INTO simulator (title, description, level, localisation, estimated_duration, created_at) VALUES ('Your Voice, Your Space', 'No description', 'core', 'digital life / social media', 0, '2026-08-23 19:54:10.823790');

-- Simulator Tags
INSERT INTO simulator_tag (name) VALUES ('digital courage');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'Your Voice, Your Space'), (SELECT id FROM simulator_tag WHERE name = 'digital courage' LIMIT 1));
INSERT INTO simulator_tag (name) VALUES ('online safety');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'Your Voice, Your Space'), (SELECT id FROM simulator_tag WHERE name = 'online safety' LIMIT 1));
INSERT INTO simulator_tag (name) VALUES ('confidence');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'Your Voice, Your Space'), (SELECT id FROM simulator_tag WHERE name = 'confidence' LIMIT 1));
INSERT INTO simulator_tag (name) VALUES ('boundaries');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'Your Voice, Your Space'), (SELECT id FROM simulator_tag WHERE name = 'boundaries' LIMIT 1));
INSERT INTO simulator_tag (name) VALUES ('social media');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'Your Voice, Your Space'), (SELECT id FROM simulator_tag WHERE name = 'social media' LIMIT 1));
INSERT INTO simulator_tag (name) VALUES ('women empowerment');
INSERT INTO simulator_contains_tag (simulator_id, simulator_tag_id) VALUES ((SELECT id FROM simulator WHERE title = 'Your Voice, Your Space'), (SELECT id FROM simulator_tag WHERE name = 'women empowerment' LIMIT 1));

-- Simulator Metrics
INSERT INTO simulator_metric (name) VALUES ('Digital Boundaries');
INSERT INTO simulator_contains_metric (simulator_id, metric_id) VALUES ((SELECT id FROM simulator WHERE title = 'Your Voice, Your Space'), (SELECT id FROM simulator_metric WHERE name = 'Digital Boundaries' LIMIT 1));
INSERT INTO simulator_metric (name) VALUES ('Online Confidence');
INSERT INTO simulator_contains_metric (simulator_id, metric_id) VALUES ((SELECT id FROM simulator WHERE title = 'Your Voice, Your Space'), (SELECT id FROM simulator_metric WHERE name = 'Online Confidence' LIMIT 1));
INSERT INTO simulator_metric (name) VALUES ('Emotional Safety');
INSERT INTO simulator_contains_metric (simulator_id, metric_id) VALUES ((SELECT id FROM simulator WHERE title = 'Your Voice, Your Space'), (SELECT id FROM simulator_metric WHERE name = 'Emotional Safety' LIMIT 1));
INSERT INTO simulator_metric (name) VALUES ('Authentic Self-Expression');
INSERT INTO simulator_contains_metric (simulator_id, metric_id) VALUES ((SELECT id FROM simulator WHERE title = 'Your Voice, Your Space'), (SELECT id FROM simulator_metric WHERE name = 'Authentic Self-Expression' LIMIT 1));

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'Your Voice, Your Space'), 1, 'The First Post', 'Sharing yourself online', 'Digital courage begins when you stop shrinking your voice online.', 'Many women hesitate to take up digital space because of fear of criticism or judgment.');

-- Component 1 for Card 0
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('A young woman sitting on her couch at night, staring at her phone while deciding whether to press “Post.”', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The First Post' AND owner_id = (SELECT id FROM simulator WHERE title = 'Your Voice, Your Space') LIMIT 1), 'image', 1, LAST_INSERT_ID());

-- Component 2 for Card 0
INSERT INTO component_text (content) VALUES ('You’ve been thinking about posting a personal reflection on LinkedIn and Instagram about your career journey. Before posting, you suddenly worry: “What if people judge me or think I’m cringe?”');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The First Post' AND owner_id = (SELECT id FROM simulator WHERE title = 'Your Voice, Your Space') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 0
INSERT INTO component_mcq (question) VALUES ('You’ve been thinking about posting a personal reflection on LinkedIn and Instagram about your career journey. Before posting, you suddenly worry: “What if people judge me or think I’m cringe?”');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You’ve been thinking about posting a personal reflection on LinkedIn and Instagram about your career journey. Before posting, you suddenly worry: “What if people judge me or think I’m cringe?”' ORDER BY id DESC LIMIT 1), 'Post it anyway because your voice deserves visibility.', 'Courage online does not mean being fearless. It means showing up even when vulnerability feels uncomfortable.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You’ve been thinking about posting a personal reflection on LinkedIn and Instagram about your career journey. Before posting, you suddenly worry: “What if people judge me or think I’m cringe?”') 
     AND option_text = 'Post it anyway because your voice deserves visibility.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Online Confidence' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You’ve been thinking about posting a personal reflection on LinkedIn and Instagram about your career journey. Before posting, you suddenly worry: “What if people judge me or think I’m cringe?”') 
     AND option_text = 'Post it anyway because your voice deserves visibility.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Authentic Self-Expression' LIMIT 1), 15);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You’ve been thinking about posting a personal reflection on LinkedIn and Instagram about your career journey. Before posting, you suddenly worry: “What if people judge me or think I’m cringe?”' ORDER BY id DESC LIMIT 1), 'Edit the post repeatedly until it feels completely “perfect.”', 'Perfectionism can become a socially acceptable form of hiding.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You’ve been thinking about posting a personal reflection on LinkedIn and Instagram about your career journey. Before posting, you suddenly worry: “What if people judge me or think I’m cringe?”') 
     AND option_text = 'Edit the post repeatedly until it feels completely “perfect.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Online Confidence' LIMIT 1), -5);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You’ve been thinking about posting a personal reflection on LinkedIn and Instagram about your career journey. Before posting, you suddenly worry: “What if people judge me or think I’m cringe?”') 
     AND option_text = 'Edit the post repeatedly until it feels completely “perfect.”' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Emotional Safety' LIMIT 1), 5);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You’ve been thinking about posting a personal reflection on LinkedIn and Instagram about your career journey. Before posting, you suddenly worry: “What if people judge me or think I’m cringe?”' ORDER BY id DESC LIMIT 1), 'Delete the post draft and decide not to share anything personal online.', 'Avoiding visibility may feel safer temporarily, but it can reinforce fear around self-expression.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You’ve been thinking about posting a personal reflection on LinkedIn and Instagram about your career journey. Before posting, you suddenly worry: “What if people judge me or think I’m cringe?”') 
     AND option_text = 'Delete the post draft and decide not to share anything personal online.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Online Confidence' LIMIT 1), -15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You’ve been thinking about posting a personal reflection on LinkedIn and Instagram about your career journey. Before posting, you suddenly worry: “What if people judge me or think I’m cringe?”') 
     AND option_text = 'Delete the post draft and decide not to share anything personal online.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Authentic Self-Expression' LIMIT 1), -10);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The First Post' AND owner_id = (SELECT id FROM simulator WHERE title = 'Your Voice, Your Space') LIMIT 1), 'mcq', 3, LAST_INSERT_ID());

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'Your Voice, Your Space'), 2, 'The Uncomfortable Message', 'A boundary gets tested', 'Setting boundaries online is not rude. It is self-respect.', 'Women are often socially conditioned to prioritize being liked over protecting their boundaries.');

-- Component 1 for Card 1
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('A close-up of a phone screen showing an uncomfortable direct message while the user looks uneasy.', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The Uncomfortable Message' AND owner_id = (SELECT id FROM simulator WHERE title = 'Your Voice, Your Space') LIMIT 1), 'image', 1, LAST_INSERT_ID());

-- Component 2 for Card 1
INSERT INTO component_text (content) VALUES ('After posting, someone sends you a message that feels invasive and overly personal. You immediately feel uncomfortable but also worry about seeming “rude.”');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The Uncomfortable Message' AND owner_id = (SELECT id FROM simulator WHERE title = 'Your Voice, Your Space') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 1
INSERT INTO component_mcq (question) VALUES ('After posting, someone sends you a message that feels invasive and overly personal. You immediately feel uncomfortable but also worry about seeming “rude.”');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'After posting, someone sends you a message that feels invasive and overly personal. You immediately feel uncomfortable but also worry about seeming “rude.”' ORDER BY id DESC LIMIT 1), 'Clearly state that the message makes you uncomfortable and end the conversation.', 'Boundaries protect your emotional safety and teach others how to treat you.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'After posting, someone sends you a message that feels invasive and overly personal. You immediately feel uncomfortable but also worry about seeming “rude.”') 
     AND option_text = 'Clearly state that the message makes you uncomfortable and end the conversation.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Digital Boundaries' LIMIT 1), 20);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'After posting, someone sends you a message that feels invasive and overly personal. You immediately feel uncomfortable but also worry about seeming “rude.”') 
     AND option_text = 'Clearly state that the message makes you uncomfortable and end the conversation.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Emotional Safety' LIMIT 1), 10);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'After posting, someone sends you a message that feels invasive and overly personal. You immediately feel uncomfortable but also worry about seeming “rude.”' ORDER BY id DESC LIMIT 1), 'Reply politely even though you feel uncomfortable.', 'Prioritizing politeness over safety can slowly normalize discomfort.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'After posting, someone sends you a message that feels invasive and overly personal. You immediately feel uncomfortable but also worry about seeming “rude.”') 
     AND option_text = 'Reply politely even though you feel uncomfortable.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Digital Boundaries' LIMIT 1), -10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'After posting, someone sends you a message that feels invasive and overly personal. You immediately feel uncomfortable but also worry about seeming “rude.”') 
     AND option_text = 'Reply politely even though you feel uncomfortable.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Emotional Safety' LIMIT 1), -5);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'After posting, someone sends you a message that feels invasive and overly personal. You immediately feel uncomfortable but also worry about seeming “rude.”' ORDER BY id DESC LIMIT 1), 'Ignore the message but keep rereading it anxiously.', 'Avoidance may reduce confrontation, but the emotional impact can still remain active internally.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'After posting, someone sends you a message that feels invasive and overly personal. You immediately feel uncomfortable but also worry about seeming “rude.”') 
     AND option_text = 'Ignore the message but keep rereading it anxiously.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Emotional Safety' LIMIT 1), -10);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The Uncomfortable Message' AND owner_id = (SELECT id FROM simulator WHERE title = 'Your Voice, Your Space') LIMIT 1), 'mcq', 3, LAST_INSERT_ID());

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'Your Voice, Your Space'), 3, 'The Comment Section', 'Public criticism appears', 'You do not need universal approval to deserve a voice.', 'Online criticism can easily trigger shame, especially for women who are taught to avoid visibility.');

-- Component 1 for Card 2
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('A social media comment section with one negative comment standing out while the creator looks discouraged.', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The Comment Section' AND owner_id = (SELECT id FROM simulator WHERE title = 'Your Voice, Your Space') LIMIT 1), 'image', 1, LAST_INSERT_ID());

-- Component 2 for Card 2
INSERT INTO component_text (content) VALUES ('One of your posts receives a dismissive comment saying: “People share way too much online these days.” Suddenly you feel embarrassed and exposed.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The Comment Section' AND owner_id = (SELECT id FROM simulator WHERE title = 'Your Voice, Your Space') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 2
INSERT INTO component_mcq (question) VALUES ('One of your posts receives a dismissive comment saying: “People share way too much online these days.” Suddenly you feel embarrassed and exposed.');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'One of your posts receives a dismissive comment saying: “People share way too much online these days.” Suddenly you feel embarrassed and exposed.' ORDER BY id DESC LIMIT 1), 'Remind yourself that disagreement does not define your value or your message.', 'Emotional safety grows when you stop treating every opinion as a verdict on your worth.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'One of your posts receives a dismissive comment saying: “People share way too much online these days.” Suddenly you feel embarrassed and exposed.') 
     AND option_text = 'Remind yourself that disagreement does not define your value or your message.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Emotional Safety' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'One of your posts receives a dismissive comment saying: “People share way too much online these days.” Suddenly you feel embarrassed and exposed.') 
     AND option_text = 'Remind yourself that disagreement does not define your value or your message.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Online Confidence' LIMIT 1), 10);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'One of your posts receives a dismissive comment saying: “People share way too much online these days.” Suddenly you feel embarrassed and exposed.' ORDER BY id DESC LIMIT 1), 'Delete the entire post immediately.', 'Removing yourself from visibility may provide relief, but it also gives fear more control over your choices.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'One of your posts receives a dismissive comment saying: “People share way too much online these days.” Suddenly you feel embarrassed and exposed.') 
     AND option_text = 'Delete the entire post immediately.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Online Confidence' LIMIT 1), -15);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'One of your posts receives a dismissive comment saying: “People share way too much online these days.” Suddenly you feel embarrassed and exposed.' ORDER BY id DESC LIMIT 1), 'Spend hours obsessing over the comment and checking whether others agree.', 'Rumination amplifies emotional stress and gives disproportionate power to negativity.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'One of your posts receives a dismissive comment saying: “People share way too much online these days.” Suddenly you feel embarrassed and exposed.') 
     AND option_text = 'Spend hours obsessing over the comment and checking whether others agree.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Emotional Safety' LIMIT 1), -15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'One of your posts receives a dismissive comment saying: “People share way too much online these days.” Suddenly you feel embarrassed and exposed.') 
     AND option_text = 'Spend hours obsessing over the comment and checking whether others agree.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Authentic Self-Expression' LIMIT 1), -5);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The Comment Section' AND owner_id = (SELECT id FROM simulator WHERE title = 'Your Voice, Your Space') LIMIT 1), 'mcq', 3, LAST_INSERT_ID());

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'Your Voice, Your Space'), 4, 'Curating Your Space', 'You decide what access people get', 'Curating your online space is not selfish. It is healthy.', 'Digital wellbeing often depends on consciously choosing what we allow into our mental space.');

-- Component 1 for Card 3
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('A woman scrolling through social media while looking emotionally exhausted, surrounded by glowing screens.', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Curating Your Space' AND owner_id = (SELECT id FROM simulator WHERE title = 'Your Voice, Your Space') LIMIT 1), 'image', 1, LAST_INSERT_ID());

-- Component 2 for Card 3
INSERT INTO component_text (content) VALUES ('You realize certain accounts consistently make you feel anxious, inadequate, or emotionally drained after scrolling.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Curating Your Space' AND owner_id = (SELECT id FROM simulator WHERE title = 'Your Voice, Your Space') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 3
INSERT INTO component_mcq (question) VALUES ('You realize certain accounts consistently make you feel anxious, inadequate, or emotionally drained after scrolling.');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You realize certain accounts consistently make you feel anxious, inadequate, or emotionally drained after scrolling.' ORDER BY id DESC LIMIT 1), 'Mute, unfollow, or limit content that negatively affects your mental wellbeing', 'Protecting your digital environment is a powerful act of emotional self-care');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You realize certain accounts consistently make you feel anxious, inadequate, or emotionally drained after scrolling.') 
     AND option_text = 'Mute, unfollow, or limit content that negatively affects your mental wellbeing' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Emotional Safety' LIMIT 1), 15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You realize certain accounts consistently make you feel anxious, inadequate, or emotionally drained after scrolling.') 
     AND option_text = 'Mute, unfollow, or limit content that negatively affects your mental wellbeing' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Digital Boundaries' LIMIT 1), 15);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You realize certain accounts consistently make you feel anxious, inadequate, or emotionally drained after scrolling.' ORDER BY id DESC LIMIT 1), 'Continue following the accounts because you feel guilty unfollowing people.', 'Guilt-based online habits can quietly undermine your confidence and emotional energy.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You realize certain accounts consistently make you feel anxious, inadequate, or emotionally drained after scrolling.') 
     AND option_text = 'Continue following the accounts because you feel guilty unfollowing people.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Emotional Safety' LIMIT 1), -10);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'You realize certain accounts consistently make you feel anxious, inadequate, or emotionally drained after scrolling.' ORDER BY id DESC LIMIT 1), 'Compare yourself constantly to the people you follow.', 'Comparison shifts focus away from your own growth and identity.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You realize certain accounts consistently make you feel anxious, inadequate, or emotionally drained after scrolling.') 
     AND option_text = 'Compare yourself constantly to the people you follow.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Authentic Self-Expression' LIMIT 1), -10);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'You realize certain accounts consistently make you feel anxious, inadequate, or emotionally drained after scrolling.') 
     AND option_text = 'Compare yourself constantly to the people you follow.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Online Confidence' LIMIT 1), -10);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Curating Your Space' AND owner_id = (SELECT id FROM simulator WHERE title = 'Your Voice, Your Space') LIMIT 1), 'mcq', 3, LAST_INSERT_ID());

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('simulator', (SELECT id FROM simulator WHERE title = 'Your Voice, Your Space'), 5, 'Showing Up Authentically', 'You redefine your online presence', 'Digital courage means protecting your peace without hiding your voice', 'Women deserve online spaces where visibility and safety can exist together');

-- Component 1 for Card 4
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('A woman smiling softly while reading an encouraging message on her phone in natural daylight.', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Showing Up Authentically' AND owner_id = (SELECT id FROM simulator WHERE title = 'Your Voice, Your Space') LIMIT 1), 'image', 1, LAST_INSERT_ID());

-- Component 2 for Card 4
INSERT INTO component_text (content) VALUES ('A younger woman messages you saying that your post inspired her to speak more confidently online. You realize your visibility may help others feel less alone');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Showing Up Authentically' AND owner_id = (SELECT id FROM simulator WHERE title = 'Your Voice, Your Space') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 4
INSERT INTO component_mcq (question) VALUES ('A younger woman messages you saying that your post inspired her to speak more confidently online. You realize your visibility may help others feel less alone');
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'A younger woman messages you saying that your post inspired her to speak more confidently online. You realize your visibility may help others feel less alone' ORDER BY id DESC LIMIT 1), 'Continue sharing thoughtfully while staying aligned with your boundaries and values.', 'Authentic self-expression becomes powerful when paired with intentional boundaries.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'A younger woman messages you saying that your post inspired her to speak more confidently online. You realize your visibility may help others feel less alone') 
     AND option_text = 'Continue sharing thoughtfully while staying aligned with your boundaries and values.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Authentic Self-Expression' LIMIT 1), 20);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'A younger woman messages you saying that your post inspired her to speak more confidently online. You realize your visibility may help others feel less alone') 
     AND option_text = 'Continue sharing thoughtfully while staying aligned with your boundaries and values.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Online Confidence' LIMIT 1), 10);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'A younger woman messages you saying that your post inspired her to speak more confidently online. You realize your visibility may help others feel less alone' ORDER BY id DESC LIMIT 1), 'Decide the attention feels overwhelming and disappear from online spaces completely.', 'Taking breaks can be healthy, but disappearing out of fear may limit meaningful connection and growth.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'A younger woman messages you saying that your post inspired her to speak more confidently online. You realize your visibility may help others feel less alone') 
     AND option_text = 'Decide the attention feels overwhelming and disappear from online spaces completely.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Online Confidence' LIMIT 1), -10);
INSERT INTO multiple_choices_options (mcq_id, option_text, feedback) VALUES ((SELECT id FROM component_mcq WHERE question = 'A younger woman messages you saying that your post inspired her to speak more confidently online. You realize your visibility may help others feel less alone' ORDER BY id DESC LIMIT 1), 'Change your content entirely to avoid criticism from others.', 'Constantly adapting yourself for approval can disconnect you from your authentic voice.');
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'A younger woman messages you saying that your post inspired her to speak more confidently online. You realize your visibility may help others feel less alone') 
     AND option_text = 'Change your content entirely to avoid criticism from others.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Authentic Self-Expression' LIMIT 1), -15);
INSERT INTO multiple_choices_options_weights (multiple_choices_options_id, simulator_metric_id, weight) VALUES ((SELECT id FROM multiple_choices_options 
     WHERE mcq_id = (SELECT id FROM component_mcq WHERE question = 'A younger woman messages you saying that your post inspired her to speak more confidently online. You realize your visibility may help others feel less alone') 
     AND option_text = 'Change your content entirely to avoid criticism from others.' 
     ORDER BY id DESC LIMIT 1), (SELECT id FROM simulator_metric WHERE name = 'Emotional Safety' LIMIT 1), -5);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Showing Up Authentically' AND owner_id = (SELECT id FROM simulator WHERE title = 'Your Voice, Your Space') LIMIT 1), 'mcq', 3, LAST_INSERT_ID());

-- ============================================
-- Feedback Tiers
-- ============================================

-- Feedback for metric 'Digital Boundaries' (Score 0-49)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Your Voice, Your Space'), (SELECT id FROM simulator_metric WHERE name = 'Digital Boundaries' LIMIT 1), 0, 49, 'You may struggle to protect your emotional space online when interactions become uncomfortable.', 'Weak boundaries can lead to emotional exhaustion and unsafe digital experiences.', 'Practice saying “I’m not comfortable with that” once in a low-pressure situation.', NULL, 'This module helps participants develop healthier and more confident online boundaries.');

-- Feedback for metric 'Online Confidence' (Score 0-49)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Your Voice, Your Space'), (SELECT id FROM simulator_metric WHERE name = 'Online Confidence' LIMIT 1), 0, 49, 'Fear of judgment may stop you from expressing yourself online.', 'Avoiding visibility can reinforce self-doubt and silence your perspective.', 'Share one authentic thought online this week without overediting it.', NULL, 'This module helps participants strengthen confidence and reduce fear of judgment in visible situations.');

-- Feedback for metric 'Emotional Safety' (Score 0-49)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Your Voice, Your Space'), (SELECT id FROM simulator_metric WHERE name = 'Emotional Safety' LIMIT 1), 0, 49, 'Online interactions may strongly affect your emotional wellbeing.', 'Exposure to criticism or unhealthy content can increase anxiety and stress.', 'Unfollow or mute one account that consistently drains your energy.', NULL, 'This module helps participants protect their emotional energy and build healthier self-care habits.');

-- Feedback for metric 'Authentic Self-Expression' (Score 0-49)
INSERT INTO simulator_feedback_tiers (simulator_id, metric_id, min_score, max_score, strength_result, risk_result, micro_practice, recommended_module_id, recommendation_reason) VALUES ((SELECT id FROM simulator WHERE title = 'Your Voice, Your Space'), (SELECT id FROM simulator_metric WHERE name = 'Authentic Self-Expression' LIMIT 1), 0, 49, 'You may hide parts of yourself online to avoid judgment or rejection.', 'Over-filtering yourself can weaken your sense of identity and connection.', 'Share one honest opinion this week without minimizing it.', NULL, 'This module helps participants reconnect with their authentic voice and personal story.');

-- ============================================
-- End of generated queries
-- ============================================
