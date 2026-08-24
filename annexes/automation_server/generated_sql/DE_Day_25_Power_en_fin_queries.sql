-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:10.436355
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Course: nan
-- ============================================

-- Category: this field must be completed ! e.g  :  I Dare, Leadership, ...
-- Check/Create category 'this field must be completed ! e.g  :  I Dare, Leadership, ...'
INSERT IGNORE INTO module_category (title, description, created_at) VALUES ('this field must be completed ! e.g  :  I Dare, Leadership, ...', 'test description', '2026-08-23 19:54:10.433856');

-- Module creation with automatic category lookup
INSERT INTO module (module_category_id, day_number, title, description, target_audience, estimated_duration, created_at) VALUES ((SELECT id FROM module_category WHERE title = 'this field must be completed ! e.g  :  I Dare, Leadership, ...'), 1, nan, nan, 'working mom, first-time managers, women, ... ', 0, '2026-08-23 19:54:10.433867');

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 1, 'Power', NULL, NULL, NULL);

-- Component 1 for Card 1
INSERT INTO component_title (content) VALUES ('Power');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Power' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 1
INSERT INTO component_text (content) VALUES ('There is NO SINGLE INTERPRETATION of power – just as power itself has many faces.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Power' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 1
INSERT INTO component_text (content) VALUES ('We start with the word: ‘POWER’ is derived from ‘to be able’, ‘to be capable’ or ‘strength’ and ‘vigor’.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Power' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 3, LAST_INSERT_ID());

-- Component 4 for Card 1
INSERT INTO component_text (content) VALUES ('Power is often viewed NEGATIVELY and associated with ‘controlling’, ‘commanding’ and ‘dominating’. Yet it also means having the means (skills) to SHAPE work and life within an association, company, family or political institutions. Power is not tied to positions. Someone can also gain influence through its particular skills. However, if positions of power are not held by ‘experts’ – that is, if the skills to give substance to that power are lacking – those in power often lose support.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Power' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 1
INSERT INTO component_text (content) VALUES ('Power thus represents a RELATIONSHIP. It depends on acceptance and can not function without COOPERATION.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Power' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 5, LAST_INSERT_ID());

-- Component 6 for Card 1
INSERT INTO component_text (content) VALUES ('Moreover and important to be aware of it, power does not operate solely through individuals. It is also exercised through seemingly anonymous CONSTRAINTS, through STRUCTURES and general RULES. You can admire or resist a powerful person. At the same time, people are part of an economic system which shapes live opportunities. Of course, driven by individuals but generating its own dynamics.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Power' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 6, LAST_INSERT_ID());

-- Component 7 for Card 1
INSERT INTO component_quote (content, author) VALUES ('No one has the right to rule over another person without their consent.', 'Abraham Lincoln');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Power' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'quote', 7, LAST_INSERT_ID());

-- Component 8 for Card 1
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('1 Macht possible towfiqu-barbhuiya-Jxi526YIQgA-unsplash.jpg', '„Possible“', '„(Im)Possible“');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Power' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'image', 8, LAST_INSERT_ID());

-- Component 9 for Card 1
INSERT INTO component_mcq (question) VALUES ('What characterises patriarchy?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'What characterises patriarchy?' ORDER BY id DESC LIMIT 1), 'Ancient Greek for ‘patriarchy’, referring to a society dominated by men in positions of power and governed by ‘masculine’ norms and rules.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'What characterises patriarchy?' ORDER BY id DESC LIMIT 1), 'A democratic form of governance, developed in ancient Patras, Greece');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'What characterises patriarchy?' ORDER BY id DESC LIMIT 1), 'Overcoming the multiple burdens faced by women (paid work, housework and child-rearing) by having men focus their activities on the outside world. This emerged when humans first began to settle in one place.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Power' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'mcq', 9, LAST_INSERT_ID());

-- Component 10 for Card 1
INSERT INTO component_open_questions (question) VALUES ('1/Think of an example where power was exercised in a constructive way. How would you describe the situation?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Power' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 10, LAST_INSERT_ID());

-- Component 11 for Card 1
INSERT INTO component_open_questions (question) VALUES ('2/ What do you think: What power mechanisms are currently at work in society and influence the possibility for individual action?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Power' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 11, LAST_INSERT_ID());

-- Component 12 for Card 1
INSERT INTO component_last_messages (content) VALUES ('How did sociologists and historians view power? Now, we turn our attention to two of them: Max Weber and Michel Foucault. But first, let us clarify what the concept of authority actually entails.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Power' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 12, LAST_INSERT_ID());

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 2, 'Authority', NULL, NULL, NULL);

-- Component 1 for Card 2
INSERT INTO component_title (content) VALUES ('Authority');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Authority' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 2
INSERT INTO component_text (content) VALUES ('Other terms are also used as alternatives to the word ‘power’: ‘authority’, ‘charisma’, ‘status’, ‘prestige’, ‘control’ and others.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Authority' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 2
INSERT INTO component_text (content) VALUES ('There is not always a clear distinction between the concepts of POWER and AUTHORITY. The political theorist HANNAH ARENDT emphasises that authority is not based on coercion, as is the case with power (temporarily) or with rule (as consolidated power) or with violence. The influence of authority is rather rooted in traditions (customs, religious precepts, etc.). Authority, however, demands OBEDIENCE. (Essay ‘What is Authority?’) Building on this, one can find confirmation of this in the anti-authoritarian aims of the 1968 movement and the social movements of the 1970s and 1980s in ‘Western’ countries. These movements were oriented towards liberation from rules and unquestioned beliefs.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Authority' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 3, LAST_INSERT_ID());

-- Component 4 for Card 2
INSERT INTO component_text (content) VALUES ('Other authors distinguish between THREE DIMENSIONS of authority: 1/ authority based on factual and specialist knowledge, 2/ authority based on functions and roles, 3/ authority based on personal qualities that confer prestige and command respect.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Authority' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 2
INSERT INTO component_text (content) VALUES ('Or to say it in simple words: HAVING POWER is associated with positions of power. Being a POWER involves natural authority based on abilities.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Authority' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 5, LAST_INSERT_ID());

-- Component 6 for Card 2
INSERT INTO component_quote (content, author) VALUES ('The sure-fire way to gain authority over people is to make yourself useful to them.', 'Marie von Ebner-Eschenbach');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Authority' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'quote', 6, LAST_INSERT_ID());

-- Component 7 for Card 2
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('2 Authority Event -974418_1280.jpg', 'Person speaking to an audience', 'Person speaking to an audience');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Authority' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'image', 7, LAST_INSERT_ID());

-- Component 8 for Card 2
INSERT INTO component_mcq (question) VALUES ('Is the Pope an authority figure?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Is the Pope an authority figure?' ORDER BY id DESC LIMIT 1), 'Yes, all his encyclicals / circulars reaffirm the dogma of infallibility. They must be obeyed.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Is the Pope an authority figure?' ORDER BY id DESC LIMIT 1), 'No, because as head of the Vatican City State, he also holds legislative, executive and judicial powers.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Is the Pope an authority figure?' ORDER BY id DESC LIMIT 1), 'Yes, the Pope embodies authority and power in one person.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Authority' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'mcq', 8, LAST_INSERT_ID());

-- Component 9 for Card 2
INSERT INTO component_last_messages (content) VALUES ('Let us now see how a ‘classic’ work in sociology defines the concepts of power and domination.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Authority' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 9, LAST_INSERT_ID());

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 3, 'Power and domination: Max Weber', NULL, NULL, NULL);

-- Component 1 for Card 3
INSERT INTO component_title (content) VALUES ('Power and domination: Max Weber');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Power and domination: Max Weber' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 3
INSERT INTO component_text (content) VALUES ('According to the sociologist Max Weber (1864–1920), POWER is ‘… any opportunity, within a social relationship, to impose one’s will even against resistance, regardless of the basis for that opportunity.’ This interpretation is very often cited and is regarded as ‘classical’.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Power and domination: Max Weber' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 3
INSERT INTO component_text (content) VALUES ('RULE or DOMINATION, on the other hand, offers, according to M. Weber, an institutionalised, established and long-term form of exercising power: it describes a relationship of superiority and subordination between rulers and the ruled and is subject to certain rules. Rulers can enforce the obedience of the ruled and thus influence their thoughts, feelings and actions.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Power and domination: Max Weber' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 3, LAST_INSERT_ID());

-- Component 4 for Card 3
INSERT INTO component_text (content) VALUES ('Where there are relationships, power is also at play. Max Weber describes it as a rather repressive form of power, one that goes hand in hand with the suppression of life’s possibilities.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Power and domination: Max Weber' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 3
INSERT INTO component_quote (content, author) VALUES ('That is the most important thing, but it is also the most difficult thing in the world: to have power without resorting to violence.', 'Astrid Lindgren');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Power and domination: Max Weber' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'quote', 5, LAST_INSERT_ID());

-- Component 6 for Card 3
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('3 Marianne_und_Max_Weber_in_Italien.jpg', 'Max Weber and his wife Marianne Weber', 'Marianne and Max Weber, appr. 1900');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Power and domination: Max Weber' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'image', 6, LAST_INSERT_ID());

-- Component 7 for Card 3
INSERT INTO component_open_questions (question) VALUES ('Have you ever experienced a situation to which Max Weber’s definitions of power and authority apply? How would you describe it?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Power and domination: Max Weber' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 7, LAST_INSERT_ID());

-- Component 8 for Card 3
INSERT INTO component_last_messages (content) VALUES ('Let us now turn to a thinker who does not view power merely as something external. It is inherent in all action.  And, in his view, power appears ‘positive’, generative. Sounds abstract? It is. And yet, in a way, it isn’t. Let us open the door to an original analyst of power.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Power and domination: Max Weber' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 8, LAST_INSERT_ID());

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 4, 'Power and Discourse – Michel Foucault', NULL, NULL, NULL);

-- Component 1 for Card 4
INSERT INTO component_title (content) VALUES ('Power and Discourse – Michel Foucault');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Power and Discourse – Michel Foucault' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 4
INSERT INTO component_text (content) VALUES ('The historian and philosopher MICHEL FOUCAULT (1926-1984) examines power relations with a view to how subjects are “made” through them.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Power and Discourse – Michel Foucault' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 4
INSERT INTO component_text (content) VALUES ('Foucault describes power as a RELATIONSHIP that occurs everywhere in society—in hospitals, prisons, academia (!), educational institutions, the military, and political institutions. It is not something one "possesses" like a king. Rather, power relations are " an ensemble of actions directed toward possible action ." Power "...tempts, seduces, facilitates or hinders; it expands or restricts possibilities for action..." It is a SOCIAL PHENOMENON that is not attached to things or people, yet is immanent in everything. Foucault conceives of power as horizontal, fluid, and multifaceted. KNOWLEDGE and DISCOURSE play a particularly important role in this.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Power and Discourse – Michel Foucault' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 3, LAST_INSERT_ID());

-- Component 4 for Card 4
INSERT INTO component_text (content) VALUES ('Through DISCOURSE, what can and cannot be said is brought into being, what is made visible and invisible. TRUTH is therefore the effect of social power relations. These determine what is considered true at any given time.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Power and Discourse – Michel Foucault' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 4
INSERT INTO component_text (content) VALUES ('Foucault offers unusual perspectives on power. It is not tied to roles or positions, but rather reflects the INTERPLAY OF FORCES within a given context. In this way, (the lack of) gender equality can be analysed in all its nuances within relationships, in the workplace, in social debates and in legislation.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Power and Discourse – Michel Foucault' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 5, LAST_INSERT_ID());

-- Component 6 for Card 4
INSERT INTO component_text (content) VALUES ('This is not about speaking up for the POWERLESSNESS. On the contrary, making strategies of discrimination and self-discrimination, of rendering people invisible, of oppression and (self-)subjugation, understandable simultaneously unlocks the POTENTIAL FOR CHANGE.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Power and Discourse – Michel Foucault' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 6, LAST_INSERT_ID());

-- Component 7 for Card 4
INSERT INTO component_quote (content, author) VALUES ('“The human being of whom we are told and whose liberation we are invited to support, is the result of a subjugation that runs far deeper than himself.”', 'Michel Foucault');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Power and Discourse – Michel Foucault' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'quote', 7, LAST_INSERT_ID());

-- Component 8 for Card 4
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('4 Michel Foucault Screenshot 2026-06-29 at 10-34-50 Michel Foucault French Philosopher Historian & Social Theorist Britannica.png', 'Portrait Michel Foucault', 'Portrait Michel Foucault');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Power and Discourse – Michel Foucault' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'image', 8, LAST_INSERT_ID());

-- Component 9 for Card 4
INSERT INTO component_open_questions (question) VALUES ('If my thoughts, feelings and actions are determined by (power) dynamics, how can I be free?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Power and Discourse – Michel Foucault' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 9, LAST_INSERT_ID());

-- Component 10 for Card 4
INSERT INTO component_last_messages (content) VALUES ('Foucault’s unconventional perspectives on society have an EMANCIPATORY AIM. But what does emancipation mean? Let’s take a brief look at this.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Power and Discourse – Michel Foucault' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 10, LAST_INSERT_ID());

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 5, 'What does emancipation mean?', NULL, NULL, NULL);

-- Component 1 for Card 5
INSERT INTO component_title (content) VALUES ('What does emancipation mean?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What does emancipation mean?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 5
INSERT INTO component_text (content) VALUES ('The noun “emancipatio” and the verb “emancipare” come from Latin and mean “to release an adult son from his father’s authority into INDEPENDANCE, or a slave into FREEDOM.” Emancipation can therefore be translated as “becoming independent.”');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What does emancipation mean?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 5
INSERT INTO component_text (content) VALUES ('The WOMEN’S MOVEMENTS of the 1920s and the 1970s and 1980s arose from the need for women’s emancipation—FOR SELF-LIBERATION—from patriarchal conditions. Women joined forces, fought together—and achieved a great deal. Today’s successes—access to education, the right to abortion, the right to vote, the right to pursue a profession, and much more—were the struggles of yesterday.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What does emancipation mean?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 3, LAST_INSERT_ID());

-- Component 4 for Card 5
INSERT INTO component_text (content) VALUES ('CRITICISM is the starting point. It often sparks change. From this, IDEAS emerge: innovations, social progress, and SHIFTS IN POWER. Ideally, this leads to more DEMOCRACY. Greater gender equality always means greater gender democracy—and, by extension, more democracy in society as a whole.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What does emancipation mean?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 5
INSERT INTO component_quote (content, author) VALUES ('It''s dangerous to stay silent for too long. Your tongue withers if you don''t use it.', 'Astrid Lindgren');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What does emancipation mean?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'quote', 5, LAST_INSERT_ID());

-- Component 6 for Card 5
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('5 Macht meg-ogHoqmRciWk-unsplash.jpg', 'Text related to power and people', 'Text: „The power of the people is stronger than the people in power!!!“');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What does emancipation mean?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'image', 6, LAST_INSERT_ID());

-- Component 7 for Card 5
INSERT INTO component_mcq (question) VALUES ('Is gender mainstreaming an example of women''s emancipation?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Is gender mainstreaming an example of women''s emancipation?' ORDER BY id DESC LIMIT 1), 'Yes, an administrative act embodies emancipation.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Is gender mainstreaming an example of women''s emancipation?' ORDER BY id DESC LIMIT 1), 'No, this is a top-down approach to promoting greater gender equality within public authorities.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What does emancipation mean?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'mcq', 7, LAST_INSERT_ID());

-- Component 8 for Card 5
INSERT INTO component_open_questions (question) VALUES ('Is gender-neutral language essential for greater gender equality? If so, why? If not, why not?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What does emancipation mean?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 8, LAST_INSERT_ID());

-- Component 9 for Card 5
INSERT INTO component_last_messages (content) VALUES ('Let us now ask: what happens when women have reached power positions?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What does emancipation mean?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 9, LAST_INSERT_ID());

-- ============================================
-- Card 6
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 6, 'Will everything be better once women are in positions of power?                                                        Let us now ask: what happens once women have reached positions of power?', NULL, NULL, NULL);

-- Component 1 for Card 6
INSERT INTO component_title (content) VALUES ('Will everything be better once women are in positions of power?                                                        Let us now ask: what happens once women have reached positions of power?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Will everything be better once women are in positions of power?                                                        Let us now ask: what happens once women have reached positions of power?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 6
INSERT INTO component_text (content) VALUES ('NO! Because that would imply that women are inherently better people. Yet the complex reality shows that this is not the case. Women can lead just as well – or just as poorly – as men.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Will everything be better once women are in positions of power?                                                        Let us now ask: what happens once women have reached positions of power?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 6
INSERT INTO component_text (content) VALUES ('A study involving 300 male and female executives shows that women in positions of power display ‘DARK TRAITS’ such as narcissism, Machiavellianism and agreeableness just as much as men. What’s more, they are said to be more competitive and rivalrous than their male colleagues. Nevertheless: “Women in leadership roles are therefore significantly more narcissistic, less agreeable, more emotionally stable, more extroverted, more creative and more conscientious.”  Source: https://www.forschung-und-lehre.de/karriere/starke-dunkle-triade-170');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Will everything be better once women are in positions of power?                                                        Let us now ask: what happens once women have reached positions of power?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 3, LAST_INSERT_ID());

-- Component 4 for Card 6
INSERT INTO component_text (content) VALUES ('The question is therefore not just how more women can reach power positions. It is also important to consider HOW women wish to give that POWER A SHAPE. In the sense of ‘alpha personalities’ who focus on dominance? What other leadership styles might be conceivable for the development of a company, a club, a public authority or in politics?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Will everything be better once women are in positions of power?                                                        Let us now ask: what happens once women have reached positions of power?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 6
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('6 Macht feel powerful toa-heftiba-BRhOrJnrWx4-unsplash.jpg', 'Graffiti at night', 'Graffiti „What makes you feel powerful?“');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Will everything be better once women are in positions of power?                                                        Let us now ask: what happens once women have reached positions of power?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'image', 5, LAST_INSERT_ID());

-- Component 6 for Card 6
INSERT INTO component_open_questions (question) VALUES ('Imagine you are the head of an organisation or a company. What do you consider important in your leadership role?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Will everything be better once women are in positions of power?                                                        Let us now ask: what happens once women have reached positions of power?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 6, LAST_INSERT_ID());

-- Component 7 for Card 6
INSERT INTO component_last_messages (content) VALUES ('If women in power positions are not necessarily better leaders, there is NO reason NOT to allow them being part of the CEO class. After all, it merely confirms the EQUALITY of men and women.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Will everything be better once women are in positions of power?                                                        Let us now ask: what happens once women have reached positions of power?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 7, LAST_INSERT_ID());

-- ============================================
-- Card 7
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 7, 'Does power now hold less power? Conclusion', NULL, NULL, NULL);

-- Component 1 for Card 7
INSERT INTO component_title (content) VALUES ('Does power now hold less power? Conclusion');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Does power now hold less power? Conclusion' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 7
INSERT INTO component_text (content) VALUES ('Power is interpreted in different ways. In any case, power reflects a relationship or reveals the balance of power in a given situation. It is worth analysing this. For recognising power, becoming more aware of it, and gaining an understanding of the interconnections makes the ‘big picture’ more manageable. It becomes ‘smaller’. And it helps us NOT TO UNDERESTIMATE ONE’S OWN POWER, but to see it as ‘greater’. An interesting area of learning – for women too.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Does power now hold less power? Conclusion' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 7
INSERT INTO component_text (content) VALUES ('Feelings of POWERLESSNESS are often linked to a lack of knowledge and an inability to express oneself. A first step towards overcoming this is to analyse power and power relations – and to engage in dialogue with others. This would be in line with the kind of action Hannah Arendt had in mind.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Does power now hold less power? Conclusion' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 3, LAST_INSERT_ID());

-- Component 4 for Card 7
INSERT INTO component_quote (content, author) VALUES ('A flea can annoy a lion more than a lion can annoy a flea. – From Africa', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Does power now hold less power? Conclusion' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'quote', 4, LAST_INSERT_ID());

-- Component 5 for Card 7
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('7 Macht viele Menschen chuttersnap-hoVa5MrjBiQ-unsplash.jpg', 'Crowd of people', 'Crowd of people');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Does power now hold less power? Conclusion' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'image', 5, LAST_INSERT_ID());

-- Component 6 for Card 7
INSERT INTO component_open_questions (question) VALUES ('When you think about your family, who do you think held the power? And how do you feel now when you think about it?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Does power now hold less power? Conclusion' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 6, LAST_INSERT_ID());

-- Component 7 for Card 7
INSERT INTO component_last_messages (content) VALUES ('WE HAVE ARRIVED. :-) Let’s now turn to the political theorist Hannah Arendt. She offers plenty of inspiration and encourages to think about making one’s own voice heard – and thereby making a difference.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Does power now hold less power? Conclusion' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 7, LAST_INSERT_ID());

-- ============================================
-- End of generated queries
-- ============================================
