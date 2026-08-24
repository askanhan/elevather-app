-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:05.083769
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Course: nan
-- ============================================

-- Category: this field must be completed ! e.g  :  I Dare, Leadership, ...
-- Check/Create category 'this field must be completed ! e.g  :  I Dare, Leadership, ...'
INSERT IGNORE INTO module_category (title, description, created_at) VALUES ('this field must be completed ! e.g  :  I Dare, Leadership, ...', 'test description', '2026-08-23 19:54:05.080981');

-- Module creation with automatic category lookup
INSERT INTO module (module_category_id, day_number, title, description, target_audience, estimated_duration, created_at) VALUES ((SELECT id FROM module_category WHERE title = 'this field must be completed ! e.g  :  I Dare, Leadership, ...'), 1, nan, nan, 'working mom, first-time managers, women, ... ', 0, '2026-08-23 19:54:05.080996');

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 1, 'Why should you always respond?', NULL, NULL, NULL);

-- Component 1 for Card 1
INSERT INTO component_title (content) VALUES ('Why should you always respond?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Why should you always respond?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 1
INSERT INTO component_text (content) VALUES ('Standing up against discrimination, including hate speech, takes courage. The key to stopping discrimination is to act quickly and not remain a passive bystander. Discrimination is the denial of rights, ridicule or mockery not because of behaviour, but, for example, on the grounds of age, gender, ability, psychosexual identity, etc. According to psychologist Gordon Allport, a lack of response to prejudice and violence leads to their escalation. It often begins with small gestures (micro-inequalities) and hate speech – the spreading of negative stereotypes, rumours, malicious jokes and hostile language – and leads to dehumanisation, the curtailment of rights, physical violence and, ultimately, to total elimination, mass killings and genocide.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Why should you always respond?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 1
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('appendix: G.Allport - The pyramid of hatred (choice colour or mono) - https://drive.google.com/file/d/1CeF-9KrDEtT9YJqznGsLsk76mhuhkTPN/view?usp=drive_link or 
https://drive.google.com/file/d/15XMDHFi9F_U22ZWWc83Zr8MS9DmL3F1o/view?usp=drive_link', NULL, 'illustrative photos from the internet; you’ll need to draw them yourself');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Why should you always respond?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'image', 3, LAST_INSERT_ID());

-- Component 4 for Card 1
INSERT INTO component_open_questions (question) VALUES ('Wave you ever witnessed unfair or discriminatory behaviour and responded effectively? Think, what helped you to respond in that situation? What made it an effective intervention?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Why should you always respond?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 4, LAST_INSERT_ID());

-- Component 5 for Card 1
INSERT INTO component_last_messages (content) VALUES ('Make sure you respond even to small jokes!');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Why should you always respond?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 5, LAST_INSERT_ID());

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 2, 'How to respond to online discrimination?', NULL, NULL, NULL);

-- Component 1 for Card 2
INSERT INTO component_title (content) VALUES ('How to respond to online discrimination?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How to respond to online discrimination?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 2
INSERT INTO component_text (content) VALUES ('Online hate is a phenomenon involving the deliberate insulting, ridiculing or harassing of a person or group of people through the publication of offensive, aggressive and contemptuous comments, posts or multimedia content on the internet. It is a form of cyberbullying. It is characterised by its aggressive nature, often being based on rumours and lies, the anonymity of those posting it, its long-term impact, and its snowball effect – a single post by one person triggers hateful posts from others.
Hate speech is extremely dangerous because it can lead to serious physical and mental health consequences, and its reach is often unlimited.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How to respond to online discrimination?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 2
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('appendix - https://drive.google.com/file/d/11x-iKc6zIUrF4E2iGqBA2T3ne0sjp91l/view?usp=drive_link', NULL, 'free from pixebay');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How to respond to online discrimination?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'image', 3, LAST_INSERT_ID());

-- Component 4 for Card 2

-- List item 4: What you can do?...
INSERT INTO component_list (content) VALUES ('What you can do?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How to respond to online discrimination?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 4, LAST_INSERT_ID());

-- List item 5: Report content: Use the platform’s tools to report...
INSERT INTO component_list (content) VALUES ('Report content: Use the platform’s tools to report posts as hate speech (a breach of the terms of service).');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How to respond to online discrimination?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: Block and ignore: Don’t get drawn into a substanti...
INSERT INTO component_list (content) VALUES ('Block and ignore: Don’t get drawn into a substantive discussion with the aggressor, as this usually fuels the hate.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How to respond to online discrimination?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- List item 7: Preserve the evidence: Take screenshots, save link...
INSERT INTO component_list (content) VALUES ('Preserve the evidence: Take screenshots, save links');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How to respond to online discrimination?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 7, LAST_INSERT_ID());

-- List item 8: Report the incident: to the police, or to organisa...
INSERT INTO component_list (content) VALUES ('Report the incident: to the police, or to organisations and bodies working to combat discrimination and hate speech');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How to respond to online discrimination?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 8, LAST_INSERT_ID());

-- Component 9 for Card 2
INSERT INTO component_last_messages (content) VALUES ('Are you familiar with the rules regarding online abuse and hate speech on the social media platforms and forums you use? If not, please check the relevant sections of the terms and conditions.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How to respond to online discrimination?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 9, LAST_INSERT_ID());

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 3, 'How should you react if you witness discrimination?', NULL, NULL, NULL);

-- Component 1 for Card 3
INSERT INTO component_title (content) VALUES ('How should you react if you witness discrimination?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How should you react if you witness discrimination?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 3
INSERT INTO component_text (content) VALUES ('It is easier to react as a bystander than when the situation affects you directly. That is why the role of a bystander is so important. Even if this behaviour is not directed at you personally, it still affects you. By reacting, you are simultaneously supporting other women and defending your own rights.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How should you react if you witness discrimination?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 3
INSERT INTO component_quote (content, author) VALUES ('When they came for the socialists, I remained silent, because I was not a socialist. When they came for the trade unionists, I did not protest, because I was not a trade unionist. Then they came for the Jews, and I did not protest, because I was not a Jew. When they came for me, there was no one left to protest.
– Martin Niemöller, Lutheran pastor', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How should you react if you witness discrimination?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 3
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1YlB1glqK_dTq9Bs5iLGUjyIEOgM-W-vA/view?usp=drive_link', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How should you react if you witness discrimination?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'image', 4, LAST_INSERT_ID());

-- Component 5 for Card 3

-- List item 5: What you can do?...
INSERT INTO component_list (content) VALUES ('What you can do?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How should you react if you witness discrimination?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: Objection: Stay calm. Say that you do not agree wi...
INSERT INTO component_list (content) VALUES ('Objection: Stay calm. Say that you do not agree with such behaviour, e.g. ‘I do not accept that sort of language’.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How should you react if you witness discrimination?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- List item 7: Educate and explain: talk to the person who has di...
INSERT INTO component_list (content) VALUES ('Educate and explain: talk to the person who has discriminated against someone – not everyone realises they are hurting someone. Ask questions:
“What do you mean?” or “Do you realise that this might be offensive?”');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How should you react if you witness discrimination?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 7, LAST_INSERT_ID());

-- List item 8: Describe the situation: Classify the comment as ha...
INSERT INTO component_list (content) VALUES ('Describe the situation: Classify the comment as hateful, hurtful or prejudiced.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How should you react if you witness discrimination?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 8, LAST_INSERT_ID());

-- List item 9: Show your support: Show solidarity with the victim...
INSERT INTO component_list (content) VALUES ('Show your support: Show solidarity with the victim; don’t leave them alone.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How should you react if you witness discrimination?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 9, LAST_INSERT_ID());

-- List item 10: Intervene: "Remove" the aggressor or the person ex...
INSERT INTO component_list (content) VALUES ('Intervene: "Remove" the aggressor or the person experiencing discrimination');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How should you react if you witness discrimination?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 10, LAST_INSERT_ID());

-- List item 11: Report the incident: to the police, or to organisa...
INSERT INTO component_list (content) VALUES ('Report the incident: to the police, or to organisations and bodies working to combat discrimination and hate speech');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How should you react if you witness discrimination?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 11, LAST_INSERT_ID());

-- Component 12 for Card 3
INSERT INTO component_open_questions (question) VALUES ('Do you know of any organisations in your area that work to combat gender discrimination? If so, visit their websites today and see what they do. If not, have a look for them online today.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How should you react if you witness discrimination?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 12, LAST_INSERT_ID());

-- Component 13 for Card 3
INSERT INTO component_last_messages (content) VALUES ('Don’t just sit back – speak up – silence means consent!');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How should you react if you witness discrimination?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 13, LAST_INSERT_ID());

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 4, 'What can you do if you experience discrimination first-hand?', NULL, NULL, NULL);

-- Component 1 for Card 4
INSERT INTO component_title (content) VALUES ('What can you do if you experience discrimination first-hand?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What can you do if you experience discrimination first-hand?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 4
INSERT INTO component_text (content) VALUES ('Remember that you have the right to be treated with dignity. Discrimination is not a personal conflict: it stems from other people’s beliefs about gender, disability, nationality, etc.
Take action if you feel uncomfortable: if your sense of dignity has been violated, you have the right to respond.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What can you do if you experience discrimination first-hand?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 4

-- List item 3: What you can do?...
INSERT INTO component_list (content) VALUES ('What you can do?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What can you do if you experience discrimination first-hand?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 3, LAST_INSERT_ID());

-- List item 4: Look after your own safety: consider whether you c...
INSERT INTO component_list (content) VALUES ('Look after your own safety: consider whether you can respond directly or whether it would be better to seek support.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What can you do if you experience discrimination first-hand?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 4, LAST_INSERT_ID());

-- List item 5: Objection: Say that you don’t agree with this beha...
INSERT INTO component_list (content) VALUES ('Objection: Say that you don’t agree with this behaviour, e.g. “I won’t accept you shouting at me.”');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What can you do if you experience discrimination first-hand?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: Educate and explain: provide feedback using the FE...
INSERT INTO component_list (content) VALUES ('Educate and explain: provide feedback using the FECE framework: Facts-Emotion-Consequences-Expectations');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What can you do if you experience discrimination first-hand?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- List item 7: Name the situation: Address the statement, not the...
INSERT INTO component_list (content) VALUES ('Name the situation: Address the statement, not the person. Describe the statement as hateful, hurtful or prejudiced.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What can you do if you experience discrimination first-hand?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 7, LAST_INSERT_ID());

-- List item 8: Break the deadlock: Get out...
INSERT INTO component_list (content) VALUES ('Break the deadlock: Get out');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What can you do if you experience discrimination first-hand?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 8, LAST_INSERT_ID());

-- List item 9: Report the incident: to the police, or to organisa...
INSERT INTO component_list (content) VALUES ('Report the incident: to the police, or to organisations and bodies working to combat discrimination and hate speech');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What can you do if you experience discrimination first-hand?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 9, LAST_INSERT_ID());

-- Component 10 for Card 4
INSERT INTO component_video (video_url, video_duration_est, video_alt, video_description) VALUES ('Model FECE_Appendix - https://docs.google.com/document/d/1U1-7ITT6lZmlXRlKJQEle_QHHRhgeZ4g/edit?usp=drive_link&ouid=107380365381383467995&rtpof=true&sd=true', NULL, NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What can you do if you experience discrimination first-hand?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'video', 10, LAST_INSERT_ID());

-- Component 11 for Card 4
INSERT INTO component_open_questions (question) VALUES ('Have you ever felt that someone has behaved towards you in a way or made comments that undermine your dignity, or that relate to your gender, age or other aspects of your identity? What might you say to such a person? Prepare a response using the FECE framework.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What can you do if you experience discrimination first-hand?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 11, LAST_INSERT_ID());

-- Component 12 for Card 4
INSERT INTO component_last_messages (content) VALUES ('Remember that discrimination in the workplace is prohibited by law.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What can you do if you experience discrimination first-hand?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 12, LAST_INSERT_ID());

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 5, 'What are micro-inequalities?', NULL, NULL, NULL);

-- Component 1 for Card 5
INSERT INTO component_title (content) VALUES ('What are micro-inequalities?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What are micro-inequalities?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 5
INSERT INTO component_text (content) VALUES ('Micro-inequalities are subtle, often unconscious behaviours (small gestures, comments, omissions) that lead to the exclusion or belittling of a person, or that express prejudice. e.g. rolling one’s eyes, sexist jokes, bypassing women when greeting them with a handshake, smirking when a woman speaks, interrupting women whilst they are speaking, snide remarks about the ‘fairer sex’, etc.
It is difficult to respond to these behaviours because they are subtle, yet they are crucial for building a culture of respect for others.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What are micro-inequalities?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 5
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('appendix- https://drive.google.com/file/d/1_zJIMjcZgXjMG9WzVmVjs06MRqUsxjm4/view?usp=drive_link', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What are micro-inequalities?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'image', 3, LAST_INSERT_ID());

-- Component 4 for Card 5
INSERT INTO component_open_questions (question) VALUES ('Have you ever wondered whether you sometimes unconsciously use micro-inequalities?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What are micro-inequalities?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 4, LAST_INSERT_ID());

-- Component 5 for Card 5
INSERT INTO component_last_messages (content) VALUES ('Micro-injustices are often downplayed and overlooked, which only serves to perpetuate them. A swift response makes it clear that such behaviour is not acceptable.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What are micro-inequalities?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 5, LAST_INSERT_ID());

-- ============================================
-- Card 6
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 6, 'Summary', NULL, NULL, NULL);

-- Component 1 for Card 6
INSERT INTO component_title (content) VALUES ('Summary');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Summary' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 6
INSERT INTO component_text (content) VALUES ('Responding to unequal treatment or discrimination requires courage, empathy and mindfulness. Speak up when someone uses gender stereotypes, undermines the role of women, or treats women and men unequally.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Summary' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 6
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('appendix - https://drive.google.com/file/d/1jhE1vfKzzb2vwAjlb1315saMkwHYpf6K/view?usp=drive_link', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Summary' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'image', 3, LAST_INSERT_ID());

-- Component 4 for Card 6
INSERT INTO component_mcq (question) VALUES ('What is your usual reaction when you witness inequality or when it affects you?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'What is your usual reaction when you witness inequality or when it affects you?' ORDER BY id DESC LIMIT 1), 'backing down, saying ‘nothing is happened’');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'What is your usual reaction when you witness inequality or when it affects you?' ORDER BY id DESC LIMIT 1), 'anger, aggressive behaviour towards the person who is discriminating');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'What is your usual reaction when you witness inequality or when it affects you?' ORDER BY id DESC LIMIT 1), 'submissiveness, making excuses');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'What is your usual reaction when you witness inequality or when it affects you?' ORDER BY id DESC LIMIT 1), 'providing constructive feedback');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'What is your usual reaction when you witness inequality or when it affects you?' ORDER BY id DESC LIMIT 1), 'others');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Summary' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'mcq', 4, LAST_INSERT_ID());

-- Component 5 for Card 6
INSERT INTO component_open_questions (question) VALUES ('Think about what you could change in your behaviour so far?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Summary' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 5, LAST_INSERT_ID());

-- Component 6 for Card 6
INSERT INTO component_last_messages (content) VALUES ('Do not tolerate any form of unequal treatment – take action!');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Summary' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 6, LAST_INSERT_ID());

-- ============================================
-- End of generated queries
-- ============================================
