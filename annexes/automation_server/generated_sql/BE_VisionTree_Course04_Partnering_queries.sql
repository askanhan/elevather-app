-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:06.537176
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Course: Partnering: The Power of Building Things with Others
-- ============================================

-- Category: Connection & Community
-- Check/Create category 'Connection & Community'
INSERT IGNORE INTO module_category (title, description, created_at) VALUES ('Connection & Community', 'test description', '2026-08-23 19:54:06.535661');

-- Module creation with automatic category lookup
INSERT INTO module (module_category_id, day_number, title, description, target_audience, estimated_duration, created_at) VALUES ((SELECT id FROM module_category WHERE title = 'Connection & Community'), 21, 'Partnering: The Power of Building Things with Others', 'Learn why partnering multiplies what you can do alone — how to choose the right partner, how to protect the relationship, and the real benefits of doing things together.', 'Women learners (18+), entrepreneurs, freelancers, professionals', 18, '2026-08-23 19:54:06.535669');

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others'), 1, 'Partnering is not networking. It is building something together.', 'Where in your work or life are you hitting a ceiling you could cross with a partner?', NULL, NULL);

-- Component 1 for Card 1
INSERT INTO component_title (content) VALUES ('Partnering is not networking. It is building something together.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Partnering is not networking. It is building something together.' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 1
INSERT INTO component_text (content) VALUES ('Networking is about people who remember you kindly. Partnering is one step deeper: it is choosing a small number of those people to actually build something with — a project, a business, a campaign, a workshop, a product. You stop being two people helping each other occasionally, and become two people sharing a goal, a risk, and often a result.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Partnering is not networking. It is building something together.' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 1
INSERT INTO component_quote (content, author) VALUES ('Alone you go faster. Together you go further — but only if you choose the right ‘together’.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Partnering is not networking. It is building something together.' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 1
INSERT INTO component_text (content) VALUES ('Many women have been quietly taught to do everything themselves — to be reliable, self-sufficient, not a burden. That is a strength, but it also becomes a ceiling. There are things you simply cannot build alone: a company that serves multiple markets, a research project that needs several disciplines, a community that needs many hands. Partnering is how you cross that ceiling without betraying your standards — by finding someone whose standards match yours.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Partnering is not networking. It is building something together.' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 1
INSERT INTO component_subtitle (content) VALUES ('Where in your work or life are you hitting a ceiling you could cross with a partner?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Partnering is not networking. It is building something together.' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'subtitle', 5, LAST_INSERT_ID());

-- Component 6 for Card 1
INSERT INTO component_open_questions (question) VALUES ('Name one thing you’ve wanted to build or achieve that you haven’t, because it felt too big to do alone. Don’t solve it yet — just name it.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Partnering is not networking. It is building something together.' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'open question', 6, LAST_INSERT_ID());

-- Component 7 for Card 1
INSERT INTO component_last_messages (content) VALUES ('Keep that idea in mind. By the end of this course, you’ll know what kind of partner you would need — and how to find her.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Partnering is not networking. It is building something together.' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'last message', 7, LAST_INSERT_ID());

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others'), 2, 'What great partnerships actually look like', 'Vision Tree × Erasmus+ partners (Brussels, ongoing)', NULL, NULL);

-- Component 1 for Card 2
INSERT INTO component_title (content) VALUES ('What great partnerships actually look like');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What great partnerships actually look like' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 2
INSERT INTO component_text (content) VALUES ('The best partnerships share one pattern: two people (or two organisations) with genuinely different strengths, pointed at the same goal. Let’s look at four real examples across very different scales — from global companies to local cooperatives — so you can see the shape of it.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What great partnerships actually look like' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 2
INSERT INTO component_subtitle (content) VALUES ('Ben & Jerry (ice cream, global)');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What great partnerships actually look like' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'subtitle', 3, LAST_INSERT_ID());

-- Component 4 for Card 2
INSERT INTO component_text (content) VALUES ('Two childhood friends opened an ice cream shop in a converted petrol station in 1978 with $12,000 and a $5 correspondence course in ice-cream making. Ben had the palate and creative instinct; Jerry had the operational discipline. Neither could have built the company alone. Their written partnership agreement also included a values clause — they committed from day one to donating a percentage of profits to social causes. That clause survived multiple acquisitions and still shapes the company today.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What great partnerships actually look like' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 2
INSERT INTO component_subtitle (content) VALUES ('Spanx × Virgin (women’s brand × distribution network)');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What great partnerships actually look like' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'subtitle', 5, LAST_INSERT_ID());

-- Component 6 for Card 2
INSERT INTO component_text (content) VALUES ('Sara Blakely built Spanx from $5,000 and a patent she wrote herself. Years in, partnership with Richard Branson’s Virgin network gave her distribution and retail access she could not have built alone in the same time. Crucially, she kept full creative and operational control — the partnership gave her reach, not a new boss. That distinction matters and we’ll come back to it.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What great partnerships actually look like' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'text', 6, LAST_INSERT_ID());

-- Component 7 for Card 2
INSERT INTO component_subtitle (content) VALUES ('Mondragón Cooperative (Basque region, Spain, since 1956)');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What great partnerships actually look like' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'subtitle', 7, LAST_INSERT_ID());

-- Component 8 for Card 2
INSERT INTO component_text (content) VALUES ('Not every successful partnership is two people. Mondragón started with five workers and a priest who believed workers should own their companies. Today it is one of Spain’s largest industrial groups — tens of thousands of worker-partners across dozens of cooperatives. Their model proves that structured partnership among many people, with clear rules on ownership and voting, can outperform traditional companies for decades. Scale is not the enemy of partnership — unclarity is.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What great partnerships actually look like' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'text', 8, LAST_INSERT_ID());

-- Component 9 for Card 2
INSERT INTO component_subtitle (content) VALUES ('Vision Tree × Erasmus+ partners (Brussels, ongoing)');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What great partnerships actually look like' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'subtitle', 9, LAST_INSERT_ID());

-- Component 10 for Card 2
INSERT INTO component_text (content) VALUES ('Closer to home: Vision Tree partners every year with organisations across Europe on Erasmus+ projects. No single organisation could deliver a multi-country youth or training programme alone — one partner brings psychological expertise, another brings reach into schools, another brings technology or local language. The projects only exist because of the partnership. This is partnering at its most practical: the work itself requires it.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What great partnerships actually look like' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'text', 10, LAST_INSERT_ID());

-- Component 11 for Card 2
INSERT INTO component_quote (content, author) VALUES ('Every partnership that lasts has the same secret: two different strengths, one shared standard.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What great partnerships actually look like' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'quote', 11, LAST_INSERT_ID());

-- Component 12 for Card 2
INSERT INTO component_open_questions (question) VALUES ('Of these four examples, which one feels closest to the kind of partnership you might build? Write one sentence about why.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What great partnerships actually look like' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'open question', 12, LAST_INSERT_ID());

-- Component 13 for Card 2
INSERT INTO component_last_messages (content) VALUES ('The scale can be small or huge. The principle is the same: complementary strengths, shared goals, clear rules.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What great partnerships actually look like' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'last message', 13, LAST_INSERT_ID());

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others'), 3, 'How to choose the right partner (and recognise the wrong one)', 'Red flags — pause if you see these', NULL, NULL);

-- Component 1 for Card 3
INSERT INTO component_title (content) VALUES ('How to choose the right partner (and recognise the wrong one)');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How to choose the right partner (and recognise the wrong one)' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 3
INSERT INTO component_text (content) VALUES ('Choosing a partner is not about finding someone who is like you. It is about finding someone whose differences complement yours — and whose values match. Research on long-term business partnerships consistently shows that value alignment predicts survival better than skill alignment. You can learn new skills. You can’t easily align values once the money or stakes get serious.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How to choose the right partner (and recognise the wrong one)' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 3
INSERT INTO component_subtitle (content) VALUES ('Green flags — look for these');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How to choose the right partner (and recognise the wrong one)' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'subtitle', 3, LAST_INSERT_ID());

-- Component 4 for Card 3
INSERT INTO component_subtitle (content) VALUES ('Red flags — pause if you see these');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How to choose the right partner (and recognise the wrong one)' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'subtitle', 4, LAST_INSERT_ID());

-- Component 5 for Card 3
INSERT INTO component_quote (content, author) VALUES ('A partner’s small reliability today is her big reliability tomorrow.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How to choose the right partner (and recognise the wrong one)' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'quote', 5, LAST_INSERT_ID());

-- Component 6 for Card 3
INSERT INTO component_mcq (question) VALUES ('You’re considering a partnership with someone talented. Twice now, she has changed meeting times last-minute. What do you do?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You’re considering a partnership with someone talented. Twice now, she has changed meeting times last-minute. What do you do?' ORDER BY id DESC LIMIT 1), 'Ignore it — she’s creative, of course she’s a bit chaotic. Sign the deal.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You’re considering a partnership with someone talented. Twice now, she has changed meeting times last-minute. What do you do?' ORDER BY id DESC LIMIT 1), 'Name it gently: ‘Before we go further, can we talk about how we’ll handle commitments?’ Watch how she responds.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You’re considering a partnership with someone talented. Twice now, she has changed meeting times last-minute. What do you do?' ORDER BY id DESC LIMIT 1), 'Secretly start the project anyway and hope reliability improves under pressure.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How to choose the right partner (and recognise the wrong one)' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'mcq', 6, LAST_INSERT_ID());

-- Component 7 for Card 3
INSERT INTO component_open_questions (question) VALUES ('Think of a potential partner in your life (real or imagined). Write one green flag she shows — and one thing you’d want to check before saying yes.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How to choose the right partner (and recognise the wrong one)' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'open question', 7, LAST_INSERT_ID());

-- Component 8 for Card 3
INSERT INTO component_last_messages (content) VALUES ('The best way to test a partnership is before it exists. Small, low-stakes collaborations reveal everything.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How to choose the right partner (and recognise the wrong one)' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'last message', 8, LAST_INSERT_ID());

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others'), 4, 'What to protect before you start', 'A simple one-page template you can use', NULL, NULL);

-- Component 1 for Card 4
INSERT INTO component_title (content) VALUES ('What to protect before you start');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What to protect before you start' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 4
INSERT INTO component_text (content) VALUES ('Most partnerships don’t fail because the partners were bad people. They fail because no one talked about the boring things early: who decides what, who gets what, what happens if one person wants to leave. The conversation feels awkward at the start of an exciting project. It is devastating when you have to have it during a crisis. Have it now, on paper, while you still like each other.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What to protect before you start' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 4
INSERT INTO component_subtitle (content) VALUES ('Five things to agree on — ideally in writing');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What to protect before you start' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'subtitle', 3, LAST_INSERT_ID());

-- Component 4 for Card 4
INSERT INTO component_quote (content, author) VALUES ('The conversation you don’t have at the start is the contract you write during the crisis.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What to protect before you start' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'quote', 4, LAST_INSERT_ID());

-- Component 5 for Card 4
INSERT INTO component_text (content) VALUES ('You don’t need a lawyer on day one for a small project. A one-page written agreement, signed by both of you, is often enough at the start. For anything involving money, legal status, or long-term commitment, invest in a proper written agreement — it protects the relationship, not just the business. The clearer the paper, the warmer the friendship stays.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What to protect before you start' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'text', 5, LAST_INSERT_ID());

-- Component 6 for Card 4
INSERT INTO component_subtitle (content) VALUES ('A simple one-page template you can use');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What to protect before you start' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'subtitle', 6, LAST_INSERT_ID());

-- Component 7 for Card 4
INSERT INTO component_mcq (question) VALUES ('A friend wants to start a small project with you. She says ‘we don’t need a written agreement — we trust each other.’ What do you do?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'A friend wants to start a small project with you. She says ‘we don’t need a written agreement — we trust each other.’ What do you do?' ORDER BY id DESC LIMIT 1), 'Agree — writing it down would feel cold and ruin the trust.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'A friend wants to start a small project with you. She says ‘we don’t need a written agreement — we trust each other.’ What do you do?' ORDER BY id DESC LIMIT 1), 'Say ‘I trust you too, which is exactly why I want us to write it down while we’re still friends.’');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'A friend wants to start a small project with you. She says ‘we don’t need a written agreement — we trust each other.’ What do you do?' ORDER BY id DESC LIMIT 1), 'Let her draft the agreement alone and sign whatever she brings.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What to protect before you start' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'mcq', 7, LAST_INSERT_ID());

-- Component 8 for Card 4
INSERT INTO component_open_questions (question) VALUES ('Which of the five points above would be hardest for you to bring up with a potential partner — and why? Write 2 sentences.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What to protect before you start' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'open question', 8, LAST_INSERT_ID());

-- Component 9 for Card 4
INSERT INTO component_last_messages (content) VALUES ('A written agreement is not a sign of distrust. It is the clearest sign of respect you can give a partner.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What to protect before you start' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'last message', 9, LAST_INSERT_ID());

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others'), 5, 'What you actually gain by partnering', 'A less talked-about benefit', NULL, NULL);

-- Component 1 for Card 5
INSERT INTO component_title (content) VALUES ('What you actually gain by partnering');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What you actually gain by partnering' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 5
INSERT INTO component_text (content) VALUES ('People talk about partnering as if it were only a business-growth strategy. It is, but the real benefits go much wider. The right partnership changes what you can do, how fast you can do it, and — this is the part nobody tells you — how you feel while doing it.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What you actually gain by partnering' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 5
INSERT INTO component_subtitle (content) VALUES ('The concrete benefits');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What you actually gain by partnering' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'subtitle', 3, LAST_INSERT_ID());

-- Component 4 for Card 5
INSERT INTO component_subtitle (content) VALUES ('A less talked-about benefit');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What you actually gain by partnering' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'subtitle', 4, LAST_INSERT_ID());

-- Component 5 for Card 5
INSERT INTO component_text (content) VALUES ('Women who work entirely alone are at higher risk of burnout, isolation and decision fatigue. A good partnership quietly protects mental health — you have someone to sanity-check decisions with, someone who notices when you are overworking, and someone who can hold the vision when you are temporarily too tired to. That is not a soft benefit. It is often the difference between a project that survives five years and one that burns out in two.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What you actually gain by partnering' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'text', 5, LAST_INSERT_ID());

-- Component 6 for Card 5
INSERT INTO component_quote (content, author) VALUES ('A good partner doesn’t just share the work. She shares the weight of the decisions.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What you actually gain by partnering' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'quote', 6, LAST_INSERT_ID());

-- Component 7 for Card 5
INSERT INTO component_open_questions (question) VALUES ('Of the benefits in the list above, which one would most change your current work or life if you had it this year?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What you actually gain by partnering' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'open question', 7, LAST_INSERT_ID());

-- Component 8 for Card 5
INSERT INTO component_last_messages (content) VALUES ('Partnering is not a weakness admission. It is the most efficient use of your own strengths.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What you actually gain by partnering' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'last message', 8, LAST_INSERT_ID());

-- ============================================
-- Card 6
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others'), 6, 'Your partnering toolkit', 'What you’ve built in this course', NULL, NULL);

-- Component 1 for Card 6
INSERT INTO component_title (content) VALUES ('Your partnering toolkit');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your partnering toolkit' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 6
INSERT INTO component_text (content) VALUES ('The best way to find out if someone could be a real partner is not to ask them. It is to do a small, low-stakes project with them first. Three months, clearly defined, clearly ended. You will learn more about someone’s reliability, values and working style in a small real project than in ten coffees.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your partnering toolkit' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 6
INSERT INTO component_subtitle (content) VALUES ('What you’ve built in this course');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your partnering toolkit' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'subtitle', 3, LAST_INSERT_ID());

-- Component 4 for Card 6
INSERT INTO component_quote (content, author) VALUES ('The fastest way to test a partnership is to run a small pilot, not to sign a big contract.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your partnering toolkit' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'quote', 4, LAST_INSERT_ID());

-- Component 5 for Card 6
INSERT INTO component_mcq (question) VALUES ('Think of the goal you named in Card 1 — the one that felt too big to do alone. What’s your first step this month?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Think of the goal you named in Card 1 — the one that felt too big to do alone. What’s your first step this month?' ORDER BY id DESC LIMIT 1), 'Keep thinking about it alone, hoping the right partner appears.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Think of the goal you named in Card 1 — the one that felt too big to do alone. What’s your first step this month?' ORDER BY id DESC LIMIT 1), 'Identify one potential partner, propose a small 3-month pilot project, agree on basic rules in writing.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Think of the goal you named in Card 1 — the one that felt too big to do alone. What’s your first step this month?' ORDER BY id DESC LIMIT 1), 'Announce the big project publicly and hope someone joins.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your partnering toolkit' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'mcq', 5, LAST_INSERT_ID());

-- Component 6 for Card 6
INSERT INTO component_open_questions (question) VALUES ('Write one sentence: ‘This month, I will explore a small pilot project with [name] by proposing [the specific small thing].’');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your partnering toolkit' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'open question', 6, LAST_INSERT_ID());

-- Component 7 for Card 6
INSERT INTO component_last_messages (content) VALUES ('You don’t have to build everything alone anymore. The right partnership is a multiplier — of work, results and courage.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your partnering toolkit' AND owner_id = (SELECT id FROM module WHERE title = 'Partnering: The Power of Building Things with Others') LIMIT 1), 'last message', 7, LAST_INSERT_ID());

-- ============================================
-- End of generated queries
-- ============================================
