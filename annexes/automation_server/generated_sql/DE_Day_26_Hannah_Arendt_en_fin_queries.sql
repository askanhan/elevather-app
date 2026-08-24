-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:08.197553
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Course: „I want to understand.“ - HANNAH ARENDT
-- ============================================

-- Category: 6 Inspiration & Role Models
-- Check/Create category '6 Inspiration & Role Models'
INSERT IGNORE INTO module_category (title, description, created_at) VALUES ('6 Inspiration & Role Models', 'test description', '2026-08-23 19:54:08.194857');

-- Module creation with automatic category lookup
INSERT INTO module (module_category_id, day_number, title, description, target_audience, estimated_duration, created_at) VALUES ((SELECT id FROM module_category WHERE title = '6 Inspiration & Role Models'), 26, '„I want to understand.“ - HANNAH ARENDT', 'Explore biographical milestones and ideas of a famous, original and courageous female thinker of the 20th century. Get inspired and encouraged to discover your own capacity for free thought and public engagement. ', 'adult learners, women, men, divers', 0, '2026-08-23 19:54:08.194869');

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT'), 1, 'Discover her biography', NULL, NULL, NULL);

-- Component 1 for Card 1
INSERT INTO component_title (content) VALUES ('Discover her biography');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 1
INSERT INTO component_text (content) VALUES ('Born in Hanover in 1906, she grew up in Königsberg (now Kaliningrad). She was an only child. Her father died when she was six years old. Her mother encouraged her education.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 1
INSERT INTO component_text (content) VALUES ('1924–28: Studied philosophy, theology and classical philology in Marburg, Freiburg im Breisgau and Heidelberg. Had a relationship with Martin Heidegger.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 3, LAST_INSERT_ID());

-- Component 4 for Card 1
INSERT INTO component_text (content) VALUES ('1928: Awarded a doctorate under Karl Jaspers on the concept of love in Augustine.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 1
INSERT INTO component_text (content) VALUES ('1929: Research in Berlin on German Romanticism. Study ‘Rahel Varnhagen: The Life Story of a German Jewess from the Romantic Era’ (published in 1959).');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 5, LAST_INSERT_ID());

-- Component 6 for Card 1
INSERT INTO component_text (content) VALUES ('1933 Fled to Paris, where she worked to assist Jewish youths in their flight to Palestine. Friendship with Walter Benjamin.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 6, LAST_INSERT_ID());

-- Component 7 for Card 1
INSERT INTO component_text (content) VALUES ('1940 Married Heinrich Blücher. Interned in a deportation camp;');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 7, LAST_INSERT_ID());

-- Component 8 for Card 1
INSERT INTO component_text (content) VALUES ('1941 Fled with her husband and mother  to New York. Worked in a publishing house and for Jewish cultural organisations.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 8, LAST_INSERT_ID());

-- Component 9 for Card 1
INSERT INTO component_text (content) VALUES ('1951 Book “The Origins of Totalitarianism”.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 9, LAST_INSERT_ID());

-- Component 10 for Card 1
INSERT INTO component_text (content) VALUES ('1953 Professorship at Brooklyn College, New York.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 10, LAST_INSERT_ID());

-- Component 11 for Card 1
INSERT INTO component_text (content) VALUES ('1960 Book “Vita Activa or On the Active Life”.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 11, LAST_INSERT_ID());

-- Component 12 for Card 1
INSERT INTO component_text (content) VALUES ('1961 Reporting on the Eichmann trial; published in 1963 as the book “Eichmann in Jerusalem: A Report on the Banality of Evil”.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 12, LAST_INSERT_ID());

-- Component 13 for Card 1
INSERT INTO component_text (content) VALUES ('1963–1967 and 1967-1975: Professor at the Universities in Chicago and New York');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 13, LAST_INSERT_ID());

-- Component 14 for Card 1
INSERT INTO component_text (content) VALUES ('Hannah Arendt died on 4 December 1975 in New York.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 14, LAST_INSERT_ID());

-- Component 15 for Card 1
INSERT INTO component_text (content) VALUES ('The life of Hannah Arendt reflects both intellectual and practical work. Her ideas might have been inspired by her diverse work experiences.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 15, LAST_INSERT_ID());

-- Component 16 for Card 1
INSERT INTO component_text (content) VALUES ('She saw herself as a secular Jew, was active in Zionist organisations, but later adopted a critical stance towards Zionism.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 16, LAST_INSERT_ID());

-- Component 17 for Card 1
INSERT INTO component_quote (content, author) VALUES ('“To influence others myself? No, I want to understand. And when other people understand in the same way that I have – that gives me a sense of fulfilment, like a sense of being at home.”', 'Hannah Arendt');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'quote', 17, LAST_INSERT_ID());

-- Component 18 for Card 1
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('1 Biography Hannah_Arendt_auf_dem_1._Kulturkritikerkongress,_Barbara_Niggl_Radloff,_FM-2019-1-5-9-16.jpg', 'Hannah Arendt', 'Hannah Arendt auf dem Kulturkritiker-Kongress 1958');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'image', 18, LAST_INSERT_ID());

-- Component 19 for Card 1
INSERT INTO component_mcq (question) VALUES ('Was Hannah Arendt a philosopher?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Was Hannah Arendt a philosopher?' ORDER BY id DESC LIMIT 1), 'Yes, her profession was to think.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Was Hannah Arendt a philosopher?' ORDER BY id DESC LIMIT 1), 'No, she considered herself as a political theorist.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Was Hannah Arendt a philosopher?' ORDER BY id DESC LIMIT 1), 'Yes, she studied philosophy, theology and classical philology.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'mcq', 19, LAST_INSERT_ID());

-- Component 20 for Card 1
INSERT INTO component_last_messages (content) VALUES ('Thinking, pondering, reflection and self-reflection can be enjoyable and allow us to sense the depth of life. Hannah Arendt provides a vivid example of this. Let’s set out on a journey to discover some of her thoughts.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'last message', 20, LAST_INSERT_ID());

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT'), 2, 'Central terms', NULL, NULL, NULL);

-- Component 1 for Card 2
INSERT INTO component_title (content) VALUES ('Central terms');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Central terms' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 2
INSERT INTO component_text (content) VALUES ('Hannah Arendt stands out as an independent, unconventional thinker. She does not construct a rigid theoretical framework. Rather, she employs conceptual terms that appear closed to life, and which are not found in this way among her male colleagues: NATALITY, the recognition of (political) PLURALITY – the multiplicity of political difference –, FRIENDSHIP, the ‘IN-BETWEEN’, FORGIVENESS, PROMISE, as well as the PUBLIC SPHERE, FREEDOM and many more. This likely also reflects her experiences from her practical work in Paris and New York.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Central terms' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 2
INSERT INTO component_text (content) VALUES ('She devotes particular attention to the POLITICAL: H. Arendt wishes to bring philosophy back into the world. Since Plato (428/427 – 347 BCE), she argues, it has been removed to a different, contemplative sphere. Yet what changes the world, she contends, are events rather than ideas. The political is the central ‘space’ in which people act, and that means shaping the world. Speaking, discussing, intervening in debates – that is acting, according to Arendt. Above all, this requires two things: courage and trust.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Central terms' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 3, LAST_INSERT_ID());

-- Component 4 for Card 2
INSERT INTO component_quote (content, author) VALUES ('„I do not deny that thinking is dangerous. But I would say not thinking is even more dangerous.“', 'Hannah Arendt');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Central terms' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'quote', 4, LAST_INSERT_ID());

-- Component 5 for Card 2
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('2 Central terms Hannah_Arendt_1924.jpg', 'Hannah Arendt', 'The intellectual in 1924');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Central terms' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'image', 5, LAST_INSERT_ID());

-- Component 6 for Card 2
INSERT INTO component_open_questions (question) VALUES ('What does ‘beginning’ or ‘bringing something into the world’ mean to you? Do you know an example?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Central terms' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'open question', 6, LAST_INSERT_ID());

-- Component 7 for Card 2
INSERT INTO component_last_messages (content) VALUES ('Start reading three of Hannah Arendt’s key works now: Let’s go.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Central terms' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'last message', 7, LAST_INSERT_ID());

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT'), 3, 'Totalitarism', NULL, NULL, NULL);

-- Component 1 for Card 3
INSERT INTO component_title (content) VALUES ('Totalitarism');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Totalitarism' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 3
INSERT INTO component_text (content) VALUES ('In general terms, totalitarianism is a form of political rule that aims at total subjugation, in which, amongst other things, individual freedom is denied and those under its rule live under the constant threat of being deprived of their very existence.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Totalitarism' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 3
INSERT INTO component_text (content) VALUES ('After the crimes of the 20th century, two world wars, fascism, the Shoah and Stalinism, Hannah Arendt also asked: How could this have happened? She examined the structural and social causes for the annihilation of plurality and individuality, freedom and justice, political action and the social struggle for truth.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Totalitarism' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 3, LAST_INSERT_ID());

-- Component 4 for Card 3
INSERT INTO component_text (content) VALUES ('H. Arendt identified three fundamental developments as the elements of totalitarian rule:');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Totalitarism' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 3
INSERT INTO component_text (content) VALUES ('1/ ANTISEMITISM is characterized by the fact that Jews were made the scapegoat for the social upheavals experienced during a time of instability, war and economic crisis.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Totalitarism' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 5, LAST_INSERT_ID());

-- Component 6 for Card 3
INSERT INTO component_text (content) VALUES ('2/ IMPERIALISM, in the form of colonialism, meant bureaucratic control of people, their surveillance and categorization, circumventing law and citizen participation. Ruling through arbitrariness, propaganda, and fear was implemented in Europe.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Totalitarism' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 6, LAST_INSERT_ID());

-- Component 7 for Card 3
INSERT INTO component_text (content) VALUES ('3/ With industrialization and population explosion – between 1750 and 1910 the number of people in German territories grew from 6 million to 65 million – MASS SOCIETY emerged. People lost their communal ties (guilds, church communities, etc.). They no longer found meaning in life through their work. They experienced abandonment and alienation. Thus atomized, ideology provided them with a sense of security. The Nazis relied on the creation of an "enemy," an "other," on fear, surveillance, discipline, and the annihilation of dissenters. What made the system possible was also the thoughtlessness of the masses. In today''s terms: SUPERFICIALITY.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Totalitarism' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 7, LAST_INSERT_ID());

-- Component 8 for Card 3
INSERT INTO component_quote (content, author) VALUES ('„The essence of totalitarian government has consisted in the effort to make human beings forget that they possess a mind.“', 'Hannah Arendt');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Totalitarism' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'quote', 8, LAST_INSERT_ID());

-- Component 9 for Card 3
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('3 Totalitarism marcin-czerniawski-m9Re9iUq08s-unsplash', 'Totalitarism – being imprisioned', 'Symbol image of being in a „Lager“ / camp');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Totalitarism' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'image', 9, LAST_INSERT_ID());

-- Component 10 for Card 3
INSERT INTO component_open_questions (question) VALUES ('Can you imagine a situation with unlimited power leading to growing violence today: in a country, at school, at work, or …');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Totalitarism' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'open question', 10, LAST_INSERT_ID());

-- Component 11 for Card 3
INSERT INTO component_last_messages (content) VALUES ('What distinguishes human beings? That is not the question Hannah Arendt asks. Rather: What are the fundamental conditions of human activity? Let’s find that out next.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Totalitarism' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'last message', 11, LAST_INSERT_ID());

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT'), 4, 'Vita activa', NULL, NULL, NULL);

-- Component 1 for Card 4
INSERT INTO component_title (content) VALUES ('Vita activa');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Vita activa' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 4
INSERT INTO component_text (content) VALUES ('Theology and philosophy often reflect on death and an afterlife. Hannah Arendt, however, focuses on natality, on beginning and actively shaping the world. She identifies three activities as fundamental human conditions: working, producing, and acting.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Vita activa' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 4
INSERT INTO component_text (content) VALUES ('WORKING is activity to secure one’s own existence. H. Arendt sees mass society as a work society: everyone should be employed.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Vita activa' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 3, LAST_INSERT_ID());

-- Component 4 for Card 4
INSERT INTO component_text (content) VALUES ('MANUFACTURING means producing something ''durable'': books, buildings, products of craftsmen in the Middle Ages.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Vita activa' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 4
INSERT INTO component_text (content) VALUES ('ACTING occurs between people when they communicate publicly, discuss, and work for the common good. Arendt modeled this on the Greek polis. In action, as in the agora, people express their uniqueness. This reveals the plurality of individuals and societies. Arendt attributes the greatest importance to action.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Vita activa' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 5, LAST_INSERT_ID());

-- Component 6 for Card 4
INSERT INTO component_quote (content, author) VALUES ('“Acting is the only activity of the vita activa that takes place directly between people, without the mediation of matter, materials or objects.”', 'Hannah Arendt');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Vita activa' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'quote', 6, LAST_INSERT_ID());

-- Component 7 for Card 4
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('4 arendt_smoking_classic-3x2', 'Hannah Arendt', 'Hannah Arendt smooking');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Vita activa' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'image', 7, LAST_INSERT_ID());

-- Component 8 for Card 4
INSERT INTO component_mcq (question) VALUES ('What means community?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'What means community?' ORDER BY id DESC LIMIT 1), 'Small-scale, close-knit social units in which emotional bonds and responsibility are important');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'What means community?' ORDER BY id DESC LIMIT 1), 'Functional alliances');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'What means community?' ORDER BY id DESC LIMIT 1), 'Work collectives');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'What means community?' ORDER BY id DESC LIMIT 1), 'Nation');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Vita activa' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'mcq', 8, LAST_INSERT_ID());

-- Component 9 for Card 4
INSERT INTO component_open_questions (question) VALUES ('What does politics mean to you? A ‘business’? A (virtual) space for free discussion and decision-making?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Vita activa' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'open question', 9, LAST_INSERT_ID());

-- Component 10 for Card 4
INSERT INTO component_last_messages (content) VALUES ('Let us now turn to Hannah Arendt’s critique of evil.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Vita activa' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'last message', 10, LAST_INSERT_ID());

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT'), 5, 'Banality of the evil', NULL, NULL, NULL);

-- Component 1 for Card 5
INSERT INTO component_title (content) VALUES ('Banality of the evil');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Banality of the evil' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 5
INSERT INTO component_text (content) VALUES ('In 1961, Adolf Eichmann, the chief organizer of the Nazi extermination of the Jews, stood trial in Jerusalem. Hannah Arendt observed the proceedings and wrote about them. In doing so, she developed a new interpretation of German fascism. Regarding Eichmann, she said: "He wanted to participate. He wanted to say ''We.''" Alone, the criminals would have been powerless. But in participation, when many come together, POWER arises. In this participation, there is also a strong SENSE OF OBLIGATION. All of this is not necessarily "evil," but rather human. Eichmann, however, was a "motiveless murderer," not a demon, because his sole aim was to FUNCTION.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Banality of the evil' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 5
INSERT INTO component_text (content) VALUES ('Reflection, empathy for the victims, responsibility—none of these played a role for him. Hannah Arendt therefore calls him a "clown," someone who was OBEDIENT. He is thus the prototype of a bureaucrat, for whom action is "pure idleness." This, Arendt argues, is precisely what characterizes EVIL in a mass society that perpetrated mass murder. Arendt describes obedience as a trait particularly pronounced in Germans.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Banality of the evil' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 3, LAST_INSERT_ID());

-- Component 4 for Card 5
INSERT INTO component_text (content) VALUES ('She also criticizes the role of the JUDENRÄTE, the Jewish officials who collaborated with the Nazis. Her provocative thesis was that fewer Jews would have been murdered without their cooperation. This sparked fierce controversy.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Banality of the evil' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 5
INSERT INTO component_quote (content, author) VALUES ('“There’s no depth to it – it’s not demonic! It’s simply a refusal to ever try to imagine what’s really going on with the other.”', 'Hannah Arendt');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Banality of the evil' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'quote', 5, LAST_INSERT_ID());

-- Component 6 for Card 5
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('5 eichmann_trial_crop.jpg', 'Adolf Eichmann', 'Eichmann at the trial');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Banality of the evil' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'image', 6, LAST_INSERT_ID());

-- Component 7 for Card 5
INSERT INTO component_mcq (question) VALUES ('What would you do if you felt pressure to join in?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'What would you do if you felt pressure to join in?' ORDER BY id DESC LIMIT 1), 'Negotiate');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'What would you do if you felt pressure to join in?' ORDER BY id DESC LIMIT 1), 'Seek support from like-minded people');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'What would you do if you felt pressure to join in?' ORDER BY id DESC LIMIT 1), 'Resist');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'What would you do if you felt pressure to join in?' ORDER BY id DESC LIMIT 1), 'Take part');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Banality of the evil' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'mcq', 7, LAST_INSERT_ID());

-- Component 8 for Card 5
INSERT INTO component_open_questions (question) VALUES ('Can you think of an example of free action in Hannah Arendt’s sense today (being in dialogue with oneself = thinking, talking to others, making decisions, taking responsibility)?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Banality of the evil' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'open question', 8, LAST_INSERT_ID());

-- Component 9 for Card 5
INSERT INTO component_last_messages (content) VALUES ('Thinking always involves criticism. H.Arendt has been criticised. What criticism has been levelled at her? Swipe to continue...');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Banality of the evil' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'last message', 9, LAST_INSERT_ID());

-- ============================================
-- Card 6
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT'), 6, 'Criticism', NULL, NULL, NULL);

-- Component 1 for Card 6
INSERT INTO component_title (content) VALUES ('Criticism');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Criticism' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 6
INSERT INTO component_text (content) VALUES ('A thinker who enjoys discussion and contributes original ideas usually also encounters opposition. Arendt’s EQUATION OF GERMAN FASCISM AND STALINISM has been widely criticized. Stalin had (supposed) opponents killed, but he did not seek to exterminate a population group. Likewise, the Soviet Union did not start a war. Distinctions and differentiations are necessary.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Criticism' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 6
INSERT INTO component_text (content) VALUES ('Another objection is that H.Arendt, while considering mass society as a cause of totalitarianism, neglects the SOCIO-ECONOMIC CONDITIONS (e.g., corporate power, financial and economic crisis).');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Criticism' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 3, LAST_INSERT_ID());

-- Component 4 for Card 6
INSERT INTO component_text (content) VALUES ('Similarly, ECONOMIC AND CULTURAL FACTORS influencing the possibility of political participation have received little attention. Arendt''s (implicit) ideal was the Greek polis. However, in this model, only men had political influence, and even then, only if they owned property.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Criticism' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 6
INSERT INTO component_text (content) VALUES ('Their criticism of the JEWISH COUNCILS was met with, among other things, the argument that it was part of such a power regime to turn victims into perpetrators.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Criticism' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 5, LAST_INSERT_ID());

-- Component 6 for Card 6
INSERT INTO component_text (content) VALUES ('With her article “REFLECTIONS ON LITTLE ROCK” (1957), she agreed with segregation in schools and thus argued in a racist manner.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Criticism' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 6, LAST_INSERT_ID());

-- Component 7 for Card 6
INSERT INTO component_text (content) VALUES ('Nevertheless, H. Arendt is recognized as an independent and courageous intellectual who promotes complex thinking also through the recognition of PLURALITY.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Criticism' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 7, LAST_INSERT_ID());

-- Component 8 for Card 6
INSERT INTO component_quote (content, author) VALUES ('“You see, I just did what I wanted to do.”', 'Hannah Arendt');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Criticism' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'quote', 8, LAST_INSERT_ID());

-- Component 9 for Card 6
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('7 Hannah Arendt Günther Gaus.png', 'Hannah Arendt', 'Hannah Arendt in conversation with Günter Gaus, 1964');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Criticism' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'image', 9, LAST_INSERT_ID());

-- Component 10 for Card 6
INSERT INTO component_open_questions (question) VALUES ('What would you appreciate, which thoughts of H. Arendt would you criticise? By which arguments?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Criticism' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'open question', 10, LAST_INSERT_ID());

-- ============================================
-- Card 7
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT'), 7, 'Thinking without constraints', NULL, NULL, NULL);

-- Component 1 for Card 7
INSERT INTO component_title (content) VALUES ('Thinking without constraints');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Thinking without constraints' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 7
INSERT INTO component_text (content) VALUES ('Hannah Arendt''s thinking defies categorisation. It stands on its own. She rejected "-isms," ideological thinking. Would she have appreciated being venerated in the way it is today? Would it be more appropriate to understand her thoughts as inspiration and encouragement—for our own thinking? At least three of her ideas can help with this:');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Thinking without constraints' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 7
INSERT INTO component_text (content) VALUES ('1/ OVERCOMING POWERLESSNESS : through self-talk (= thinking), exchanging ideas with a friend, and joining forces with others – taking action. This also expresses individual freedom.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Thinking without constraints' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 3, LAST_INSERT_ID());

-- Component 4 for Card 7
INSERT INTO component_text (content) VALUES ('2/ “NO ONE HAS THE RIGHT TO OBEY ACCORDING TO KANT.” This refers to Immanuel Kant’s “Sapere aude,” that is, the “courage to use one’s own understanding.” Arendt also formulated this sentence with regard to the responsibility of the individual.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Thinking without constraints' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 7
INSERT INTO component_text (content) VALUES ('3/ SOVEREIGNTY THROUGH LAUGHTER : “Great political criminals must be exposed and exposed especially to laughter.” (Bertolt Brecht) H. Arendt concedes that one can even come to terms with the horror by exposing it to laughter – and thus retain one''s dignity.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Thinking without constraints' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'text', 5, LAST_INSERT_ID());

-- Component 6 for Card 7
INSERT INTO component_open_questions (question) VALUES ('People are not completely powerless. Moreover, they often underestimate its power potentials. Do you agree?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Thinking without constraints' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'open question', 6, LAST_INSERT_ID());

-- Component 7 for Card 7
INSERT INTO component_last_messages (content) VALUES ('You''ve arrived! We''re glad you decided to come along.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Thinking without constraints' AND owner_id = (SELECT id FROM module WHERE title = '„I want to understand.“ - HANNAH ARENDT') LIMIT 1), 'last message', 7, LAST_INSERT_ID());

-- ============================================
-- End of generated queries
-- ============================================
