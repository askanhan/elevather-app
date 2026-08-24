-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:10.520314
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Course: Digital Courage: Setting Boundaries & Showing Up Safely Online
-- ============================================

-- Category: Confidence and Communication
-- Check/Create category 'Confidence and Communication'
INSERT IGNORE INTO module_category (title, description, created_at) VALUES ('Confidence and Communication', 'test description', '2026-08-23 19:54:10.518317');

-- Module creation with automatic category lookup
INSERT INTO module (module_category_id, day_number, title, description, target_audience, estimated_duration, created_at) VALUES ((SELECT id FROM module_category WHERE title = 'Confidence and Communication'), 5, 'Digital Courage: Setting Boundaries & Showing Up Safely Online', 'Recognize digital power dynamics, set clear online boundaries, and build the confidence to show up authentically and safely in digital spaces.', 'women learners', 14, '2026-08-23 19:54:10.518327');

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online'), 1, 'You Have the Right to Take Up Digital Space', NULL, NULL, NULL);

-- Component 1 for Card 1
INSERT INTO component_title (content) VALUES ('You Have the Right to Take Up Digital Space');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'You Have the Right to Take Up Digital Space' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 1
INSERT INTO component_text (content) VALUES ('Women face specific barriers to full participation in online spaces – from harassment and tone policing to the pressure to self-censor. Research by the EU Agency for Fundamental Rights (2021) shows that 1 in 2 women who have experienced online harassment changed their online behavior as a result. This lesson is about reclaiming your digital presence – with clarity, boundaries, and courage.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'You Have the Right to Take Up Digital Space' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 1
INSERT INTO component_quote (content, author) VALUES ('You can''t go back and change the beginning, but you can start where you are and change the ending.: C.S. Lewis', 'write the author''s name here');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'You Have the Right to Take Up Digital Space' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 1
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1F4SXI1HY2Xp-Ck2ITOSR7P2Z_7hGpJBm/view?usp=drive_link', 'short description of what the image is', 'detailed explanation of what the image shows');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'You Have the Right to Take Up Digital Space' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'image', 4, LAST_INSERT_ID());

-- Component 5 for Card 1
INSERT INTO component_video (video_url, video_duration_est, video_alt, video_description) VALUES ('https://drive.google.com/file/d/1NH_ENhdmotdok1_-V4ybkLSLiW7IUYUS/view?usp=drive_link', 'must be a number', 'short description of what the image is', 'detailed explanation of what the image shows');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'You Have the Right to Take Up Digital Space' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'video', 5, LAST_INSERT_ID());

-- Component 6 for Card 1
INSERT INTO component_last_messages (content) VALUES ('Let''s start with what''s actually happening online – and what you can do about it');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'You Have the Right to Take Up Digital Space' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'last message', 6, LAST_INSERT_ID());

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online'), 2, 'The Online Gender Power Gap is Real', 'Have you ever held back online because of how you thought you''d be perceived?', NULL, NULL);

-- Component 1 for Card 2
INSERT INTO component_title (content) VALUES ('The Online Gender Power Gap is Real');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The Online Gender Power Gap is Real' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 2
INSERT INTO component_text (content) VALUES ('Online spaces are not neutral. Research shows that women, especially those at the intersection of multiple marginalized identities, face more frequent and more severe online harassment than men. This shapes who speaks, who is heard, and who stays silent. Recognizing this as a structural issue – not a personal failure – is the first step to digital courage.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The Online Gender Power Gap is Real' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 2
INSERT INTO component_quote (content, author) VALUES ('What begins online, doesn''t stay online. Digital abuse spills into real life, spreading fear, silencing voices, and - in the worst cases - leading to physical violence and femicide. : Sima Bahous (UN Women Executive Director)', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The Online Gender Power Gap is Real' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 2
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1zi51F0QjJmr-67GAmsUPnaqwXPtzSegD/view?usp=drive_link', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The Online Gender Power Gap is Real' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'image', 4, LAST_INSERT_ID());

-- Component 5 for Card 2
INSERT INTO component_subtitle (content) VALUES ('Have you ever held back online because of how you thought you''d be perceived?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The Online Gender Power Gap is Real' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'subtitle', 5, LAST_INSERT_ID());

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online'), 3, 'What a Digital Boundary Looks Like', 'Do any of these sound familiar?', NULL, NULL);

-- Component 1 for Card 3
INSERT INTO component_title (content) VALUES ('What a Digital Boundary Looks Like');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What a Digital Boundary Looks Like' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 3
INSERT INTO component_text (content) VALUES ('A digital boundary is a clear decision about what you will and will not engage with online – and how you communicate that. It applies to what you share, who you respond to, how you handle conflict, and what behavior you tolerate in your spaces. Like all boundaries, digital ones need to be defined by you – not determined by fear.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What a Digital Boundary Looks Like' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 3
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/13s5Gw7fNa7-PBRqQu5vkrA6J-7xrIJCR/view?usp=drive_link', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What a Digital Boundary Looks Like' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'image', 3, LAST_INSERT_ID());

-- Component 4 for Card 3
INSERT INTO component_subtitle (content) VALUES ('Do any of these sound familiar?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What a Digital Boundary Looks Like' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'subtitle', 4, LAST_INSERT_ID());

-- Component 5 for Card 3
INSERT INTO component_last_messages (content) VALUES ('Digital boundaries can include');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What a Digital Boundary Looks Like' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'last message', 5, LAST_INSERT_ID());

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online'), 4, 'Respond – Don''t React', NULL, NULL, NULL);

-- Component 1 for Card 4
INSERT INTO component_title (content) VALUES ('Respond – Don''t React');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Respond – Don''t React' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 4
INSERT INTO component_text (content) VALUES ('Online conflict often triggers a fast emotional reaction – anger, shame, or the urge to over-explain. Communication research shows that pausing before responding gives you back agency. A response is intentional. A reaction is automatic. This skill is trainable.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Respond – Don''t React' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 4
INSERT INTO component_quote (content, author) VALUES ('Practice the pause. Pause before judging. Pause before assuming. Pause before accusing. Pause whenever you''re about to react harshly and you''ll avoid doing and saying things you''ll later regret. : Lori Deschene', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Respond – Don''t React' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 4
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/12eCOM0FYc7GI1UijWBofKdwIQ4rNwMM7/view?usp=drive_link', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Respond – Don''t React' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'image', 4, LAST_INSERT_ID());

-- Component 5 for Card 4
INSERT INTO component_mcq (question) VALUES ('Someone posts a dismissive comment on something you shared. What is your first impulse?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Someone posts a dismissive comment on something you shared. What is your first impulse?' ORDER BY id DESC LIMIT 1), 'Delete the post – not worth it');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Someone posts a dismissive comment on something you shared. What is your first impulse?' ORDER BY id DESC LIMIT 1), 'Reply immediately and defend myself.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Someone posts a dismissive comment on something you shared. What is your first impulse?' ORDER BY id DESC LIMIT 1), 'Take a breath and decide later if it''s worth a response.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Respond – Don''t React' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'mcq', 5, LAST_INSERT_ID());

-- Component 6 for Card 4
INSERT INTO component_last_messages (content) VALUES ('All of these are understandable. The goal is not a perfect reaction – it''s awareness of your pattern, so you can choose.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Respond – Don''t React' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'last message', 6, LAST_INSERT_ID());

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online'), 5, 'Showing Up – On Your Own Terms', NULL, NULL, NULL);

-- Component 1 for Card 5
INSERT INTO component_title (content) VALUES ('Showing Up – On Your Own Terms');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Showing Up – On Your Own Terms' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 5
INSERT INTO component_text (content) VALUES ('Digital courage is not about being fearless. It is about showing up anyway – with a clear sense of what you stand for and what you will not accept. Practical digital safety includes both technical tools (privacy settings, two-factor authentication, screenshot documentation) and relational strategies (knowing who to contact, how to report, where to find support).');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Showing Up – On Your Own Terms' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 5
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/10lpqtEBeW2FL3Vevjl6bkRmpU2a8wIt3/view?usp=drive_link', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Showing Up – On Your Own Terms' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'image', 3, LAST_INSERT_ID());

-- Component 4 for Card 5
INSERT INTO component_open_questions (question) VALUES ('Name one digital space where you want to show up more fully. What is one thing holding you back – and one concrete step you could take?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Showing Up – On Your Own Terms' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'open question', 4, LAST_INSERT_ID());

-- Component 5 for Card 5

-- List item 5: Concrete steps to show up more safely:...
INSERT INTO component_list (content) VALUES ('Concrete steps to show up more safely:');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Showing Up – On Your Own Terms' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: Review your privacy settings on each platform you ...
INSERT INTO component_list (content) VALUES ('Review your privacy settings on each platform you use.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Showing Up – On Your Own Terms' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- List item 7: Know how to report harassment on every platform wh...
INSERT INTO component_list (content) VALUES ('Know how to report harassment on every platform where you are active.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Showing Up – On Your Own Terms' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'list', 7, LAST_INSERT_ID());

-- List item 8: Build a small trusted circle you can consult befor...
INSERT INTO component_list (content) VALUES ('Build a small trusted circle you can consult before reacting.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Showing Up – On Your Own Terms' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'list', 8, LAST_INSERT_ID());

-- ============================================
-- Card 6
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online'), 6, 'Your Voice Belongs Online Too', NULL, NULL, NULL);

-- Component 1 for Card 6
INSERT INTO component_title (content) VALUES ('Your Voice Belongs Online Too');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your Voice Belongs Online Too' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 6
INSERT INTO component_text (content) VALUES ('Research on digital gender gaps consistently shows that women''s voices are underrepresented in public digital discourse – not because women have less to say, but because the costs of speaking are higher. Reclaiming your digital voice is not just a personal act. It is a political one.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your Voice Belongs Online Too' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 6
INSERT INTO component_quote (content, author) VALUES ('If we do not share our stories and shine a light on inequities, things will not change. : Ellen Pao (Former CEO of Reddit)', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your Voice Belongs Online Too' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 6
INSERT INTO component_open_questions (question) VALUES ('Write one thing you have wanted to say online – in a comment, a post, a message – but held back. What stopped you? What would it look like to say it anyway?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your Voice Belongs Online Too' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'open question', 4, LAST_INSERT_ID());

-- Component 5 for Card 6
INSERT INTO component_last_messages (content) VALUES ('Our voice matters in digital spaces too. That is not arrogance. That is fact.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your Voice Belongs Online Too' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'last message', 5, LAST_INSERT_ID());

-- ============================================
-- Card 7
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online'), 7, 'What You Practiced', NULL, NULL, NULL);

-- Component 1 for Card 7
INSERT INTO component_title (content) VALUES ('What You Practiced');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What You Practiced' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 7
INSERT INTO component_text (content) VALUES ('/ /  /  / Your digital voice is part of your power.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What You Practiced' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 7
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1NTtt775X1uiJ3x7KDn6Ahoqr9tUox2Nj/view?usp=drive_link', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What You Practiced' AND owner_id = (SELECT id FROM module WHERE title = 'Digital Courage: Setting Boundaries & Showing Up Safely Online') LIMIT 1), 'image', 3, LAST_INSERT_ID());

-- ============================================
-- End of generated queries
-- ============================================
