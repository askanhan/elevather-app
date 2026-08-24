-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:06.574809
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Course: Day 5: Rebiya Kadeer — Staying Strong Under Pressure
-- ============================================

-- Category: 6
-- Check/Create category '6'
INSERT IGNORE INTO module_category (title, description, created_at) VALUES ('6', 'test description', '2026-08-23 19:54:06.572757');

-- Module creation with automatic category lookup
INSERT INTO module (module_category_id, day_number, title, description, target_audience, estimated_duration, created_at) VALUES ((SELECT id FROM module_category WHERE title = '6'), 29, 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure', 'Through Rebiya Kadeer’s life — from rural poverty to one of China’s largest fortunes to prison and exile — learn how a woman can build, lead, and stay whole even when everything pushes back.', 'Women learners (18+)', 18, '2026-08-23 19:54:06.572766');

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure'), 1, 'A life almost too large to take in', 'Before we start', NULL, NULL);

-- Component 1 for Card 1
INSERT INTO component_title (content) VALUES ('A life almost too large to take in');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'A life almost too large to take in' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 1
INSERT INTO component_text (content) VALUES ('Some women are inspiring because their lives are easy to imagine. Others, like Rebiya Kadeer, are almost too large to take in — and that is exactly why we should look at them carefully. She was born into rural poverty in 1946 in northwestern China. She was married as a teenager. She built one of the largest fortunes in the country. She was imprisoned for nearly six years. She has lived in exile for the past two decades. She is the mother of eleven children. She has been nominated for the Nobel Peace Prize.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'A life almost too large to take in' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 1
INSERT INTO component_quote (content, author) VALUES ('Some lives are not lessons in success. They are lessons in staying yourself.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'A life almost too large to take in' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 1
INSERT INTO component_text (content) VALUES ('Kadeer is a Uyghur — a Turkic Muslim people whose homeland in northwestern China is officially called the Xinjiang Uyghur Autonomous Region, and which Uyghurs themselves often call East Turkistan. Her story is not a fairy tale, and it does not have a tidy happy ending. It is something better: a study, told over many decades, in what real strength looks like in a real woman’s life. Over the next five cards, we will look at how she rose, what she chose, what it cost her, and how she stayed whole — so that we can learn from her in our own, much smaller daily moments of pressure.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'A life almost too large to take in' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 1
INSERT INTO component_subtitle (content) VALUES ('Before we start');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'A life almost too large to take in' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'subtitle', 5, LAST_INSERT_ID());

-- Component 6 for Card 1
INSERT INTO component_open_questions (question) VALUES ('Have you ever heard of Rebiya Kadeer before? If yes, what did you know? If no, write down — in one sentence — what you most want to understand about a woman who built a fortune and then lost almost everything for speaking out.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'A life almost too large to take in' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'open question', 6, LAST_INSERT_ID());

-- Component 7 for Card 1
INSERT INTO component_last_messages (content) VALUES ('Most of us will never face what Kadeer faced. But the muscles she trained — staying yourself under pressure — are ones we all need, in our own size, in our own lives.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'A life almost too large to take in' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'last message', 7, LAST_INSERT_ID());

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure'), 2, 'From a sewing needle to one of China’s largest fortunes', 'What she did with the money', NULL, NULL);

-- Component 1 for Card 2
INSERT INTO component_title (content) VALUES ('From a sewing needle to one of China’s largest fortunes');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'From a sewing needle to one of China’s largest fortunes' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 2
INSERT INTO component_text (content) VALUES ('Kadeer did not start with anything. She grew up poor, married young, and by her mid-twenties she had six children. She lived through the Cultural Revolution — a decade in China when private trade was politically dangerous and ordinary families could lose everything for the wrong opinion. During those years, she sewed clothes and small goods at home and sold them quietly, just to keep her children fed. That was her first act of quiet defiance — not a political one, just a human one: do what is needed, regardless of the rules, when the rules are starving your family.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'From a sewing needle to one of China’s largest fortunes' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 2
INSERT INTO component_quote (content, author) VALUES ('Long before she stood at a microphone, she was sitting at a table with a needle. The same woman did both.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'From a sewing needle to one of China’s largest fortunes' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 2
INSERT INTO component_subtitle (content) VALUES ('When the doors began to open');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'From a sewing needle to one of China’s largest fortunes' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'subtitle', 4, LAST_INSERT_ID());

-- Component 5 for Card 2
INSERT INTO component_text (content) VALUES ('When China’s economy began to open in the late 1970s, Kadeer was ready. She started small — a laundry, then trading fruit, vegetables and leather goods. She moved into department stores, real estate, and cross-border trade with the new Central Asian republics after the Soviet Union dissolved. By the 1990s she was widely reported to be one of the wealthiest people in the country. Forbes listed her among China’s richest. She was nicknamed ‘the millionairess’ — in a country that did not, at the time, expect women, and certainly not Uyghur women, to be millionaires.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'From a sewing needle to one of China’s largest fortunes' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'text', 5, LAST_INSERT_ID());

-- Component 6 for Card 2
INSERT INTO component_subtitle (content) VALUES ('What she did with the money');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'From a sewing needle to one of China’s largest fortunes' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'subtitle', 6, LAST_INSERT_ID());

-- Component 7 for Card 2
INSERT INTO component_text (content) VALUES ('Most fortunes shrink the people who hold them. Kadeer’s did the opposite. She founded the ‘Thousand Mothers Movement’ — a charity that helped Uyghur women start their own small businesses and become financially independent. She supported orphaned children. She mentored other women in trade. She knew exactly what it was like to be a woman with no money and a family to feed, and she used her fortune to make sure other women had what she once didn’t.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'From a sewing needle to one of China’s largest fortunes' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'text', 7, LAST_INSERT_ID());

-- Component 8 for Card 2
INSERT INTO component_mcq (question) VALUES ('What is the most useful lesson from Kadeer’s rise from poverty to wealth?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'What is the most useful lesson from Kadeer’s rise from poverty to wealth?' ORDER BY id DESC LIMIT 1), 'If you’re poor, you can’t build anything; the system is rigged.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'What is the most useful lesson from Kadeer’s rise from poverty to wealth?' ORDER BY id DESC LIMIT 1), 'Start with whatever small thing is in front of you, build patiently, and use what you gain to lift others with you.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'What is the most useful lesson from Kadeer’s rise from poverty to wealth?' ORDER BY id DESC LIMIT 1), 'Wait until conditions are perfect, then make one big move when you’re ready.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'From a sewing needle to one of China’s largest fortunes' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'mcq', 8, LAST_INSERT_ID());

-- Component 9 for Card 2
INSERT INTO component_open_questions (question) VALUES ('What is the smallest thing you could start today — a project, a habit, a side income — that you have been waiting for ‘the right conditions’ to begin? Write it down.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'From a sewing needle to one of China’s largest fortunes' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'open question', 9, LAST_INSERT_ID());

-- Component 10 for Card 2
INSERT INTO component_last_messages (content) VALUES ('She did not wait for the right conditions. She started with a needle. The conditions came later.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'From a sewing needle to one of China’s largest fortunes' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'last message', 10, LAST_INSERT_ID());

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure'), 3, 'The choice that changed everything', 'Why this matters for the rest of us', NULL, NULL);

-- Component 1 for Card 3
INSERT INTO component_title (content) VALUES ('The choice that changed everything');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The choice that changed everything' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 3
INSERT INTO component_text (content) VALUES ('By the mid-1990s, Kadeer was held up by the Chinese government itself as a model citizen — a woman, a Muslim, a member of an ethnic minority, and a business success. She had a seat at the National People’s Congress in Beijing. She had been a delegate at the 1995 UN World Conference on Women. Almost no other Uyghur woman had reached that height. She could have stayed there — wealthy, celebrated, politically protected — for the rest of her life.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The choice that changed everything' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 3
INSERT INTO component_quote (content, author) VALUES ('Real choices are not made when everything is easy. They are made when staying silent is easier than speaking.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The choice that changed everything' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 3
INSERT INTO component_subtitle (content) VALUES ('March 1997');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The choice that changed everything' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'subtitle', 4, LAST_INSERT_ID());

-- Component 5 for Card 3
INSERT INTO component_text (content) VALUES ('In March 1997, in front of the National People’s Congress, Kadeer gave a speech that departed from the officially approved text. She spoke about the human-rights situation of Uyghurs in her homeland, and criticised the Chinese government’s harsh response to recent Uyghur protests in Ghulja. From that moment, the protection she had enjoyed disappeared. She was stripped of her political positions. Her passport was confiscated. She kept speaking anyway.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The choice that changed everything' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'text', 5, LAST_INSERT_ID());

-- Component 6 for Card 3
INSERT INTO component_subtitle (content) VALUES ('Why this matters for the rest of us');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The choice that changed everything' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'subtitle', 6, LAST_INSERT_ID());

-- Component 7 for Card 3
INSERT INTO component_text (content) VALUES ('Most of us will never speak in front of a parliament. But almost every woman has had a smaller version of Kadeer’s 1997 moment — a meeting where the truth needs to be said and won’t be convenient, a family dinner where someone is being unfair to someone else, a workplace where ‘everyone agrees’ but you can see what is wrong. The pattern is the same: there is a comfortable version where you keep what you have, and a more honest version where you risk it. The cost of the second is real. The cost of the first is also real — it just shows up later, as a quieter kind of self-loss.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The choice that changed everything' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'text', 7, LAST_INSERT_ID());

-- Component 8 for Card 3
INSERT INTO component_mcq (question) VALUES ('Looking at Kadeer’s 1997 choice, what is the everyday version most women face?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Looking at Kadeer’s 1997 choice, what is the everyday version most women face?' ORDER BY id DESC LIMIT 1), 'A dramatic, public moment that defines your whole life in one speech.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Looking at Kadeer’s 1997 choice, what is the everyday version most women face?' ORDER BY id DESC LIMIT 1), 'Smaller moments — a meeting, a conversation, a family table — where staying silent is easier than saying what is true.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Looking at Kadeer’s 1997 choice, what is the everyday version most women face?' ORDER BY id DESC LIMIT 1), 'There is no everyday version. Only public figures face this kind of decision.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The choice that changed everything' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'mcq', 8, LAST_INSERT_ID());

-- Component 9 for Card 3
INSERT INTO component_open_questions (question) VALUES ('Think of a recent moment when you had a small ‘1997’ — a moment to speak honestly that would have cost something. Did you speak, or stay silent? What would you do differently next time? Write 2–3 sentences.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The choice that changed everything' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'open question', 9, LAST_INSERT_ID());

-- Component 10 for Card 3
INSERT INTO component_last_messages (content) VALUES ('Courage is not always loud. Sometimes it is one woman, in a chair, deciding which version of the truth to read out loud.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The choice that changed everything' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'last message', 10, LAST_INSERT_ID());

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure'), 4, 'What it cost her', 'Why this matters for us', NULL, NULL);

-- Component 1 for Card 4
INSERT INTO component_title (content) VALUES ('What it cost her');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What it cost her' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 4
INSERT INTO component_text (content) VALUES ('Inspirational stories often skip this part. We are going to spend a whole card here, because if we don’t, the lessons in the next card will mean nothing. Real strength under pressure is not free. Kadeer paid, and her family paid, and the truthful version of her story has to include that.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What it cost her' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 4
INSERT INTO component_subtitle (content) VALUES ('Arrest');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What it cost her' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'subtitle', 3, LAST_INSERT_ID());

-- Component 4 for Card 4
INSERT INTO component_text (content) VALUES ('In August 1999, on her way to meet a US congressional delegation visiting Xinjiang to look into the human-rights situation there, Kadeer was arrested. She was convicted of ‘endangering state security’ — the official charge was that she had sent newspaper clippings to her husband, who was by then living in exile in the United States. She was sentenced to eight years.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What it cost her' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 4
INSERT INTO component_subtitle (content) VALUES ('Prison');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What it cost her' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'subtitle', 5, LAST_INSERT_ID());

-- Component 6 for Card 4
INSERT INTO component_text (content) VALUES ('She served nearly six years, much of it in harsh conditions, including extended periods of isolation. She was reportedly held in a cell at the Liudaowan prison in Ürümqi. International human-rights organisations campaigned continuously for her release. The Norwegian Rafto Foundation awarded her the Rafto Prize for Human Rights in 2004 while she was still in prison. In 2005, after sustained international pressure, she was released on medical grounds and exiled to the United States.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What it cost her' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'text', 6, LAST_INSERT_ID());

-- Component 7 for Card 4
INSERT INTO component_subtitle (content) VALUES ('Her family');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What it cost her' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'subtitle', 7, LAST_INSERT_ID());

-- Component 8 for Card 4
INSERT INTO component_text (content) VALUES ('After her exile, several of her sons in China were arrested in what international human-rights organisations described as retaliation for her continued advocacy abroad. The US House of Representatives passed a resolution in 2007 calling for the release of her imprisoned children. She has not seen most of her family in person since 2005. She still speaks publicly. She still leads. The cost has not stopped, and she has not stopped either.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What it cost her' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'text', 8, LAST_INSERT_ID());

-- Component 9 for Card 4
INSERT INTO component_quote (content, author) VALUES ('Standing up costs something. Pretending you don’t see what is happening costs something too. The second cost is just quieter, and we hardly ever name it.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What it cost her' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'quote', 9, LAST_INSERT_ID());

-- Component 10 for Card 4
INSERT INTO component_subtitle (content) VALUES ('Why this matters for us');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What it cost her' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'subtitle', 10, LAST_INSERT_ID());

-- Component 11 for Card 4
INSERT INTO component_text (content) VALUES ('Most women reading this will never face anything close to prison or exile. But every woman knows the smaller version of this trade — the friendship that ends because you set a boundary, the job you lose because you raised an issue, the family member who stops speaking to you because you would not lie for them. None of these are nothing. Naming the real cost of standing up does not make people weaker. It is the only way the strength in the next card will feel honest, instead of like another inspirational poster.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What it cost her' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'text', 11, LAST_INSERT_ID());

-- Component 12 for Card 4
INSERT INTO component_open_questions (question) VALUES ('What is one cost you have already paid for staying yourself — for not bending, not lying, not staying silent? Write it down. Naming it is part of honouring it.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What it cost her' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'open question', 12, LAST_INSERT_ID());

-- Component 13 for Card 4
INSERT INTO component_last_messages (content) VALUES ('Strength is not free. Anyone who tells you it is, is selling you something. What we’ll look at next is how to carry that cost without letting it break you.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What it cost her' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'last message', 13, LAST_INSERT_ID());

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure'), 5, 'How she stayed whole — five practices anyone can borrow', '5. She kept her dignity as a daily practice', NULL, NULL);

-- Component 1 for Card 5
INSERT INTO component_title (content) VALUES ('How she stayed whole — five practices anyone can borrow');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How she stayed whole — five practices anyone can borrow' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 5
INSERT INTO component_text (content) VALUES ('Kadeer has spoken openly, in interviews and in her autobiography ‘Dragon Fighter’, about how she survived prison, exile and the imprisonment of her own children. She did not survive by being fearless. She survived by holding onto specific things that kept her whole. None of these require a public stage. They are useful to any woman facing pressure, loss or sustained difficulty in her own life.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How she stayed whole — five practices anyone can borrow' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 5
INSERT INTO component_subtitle (content) VALUES ('1. She kept her purpose larger than her circumstances');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How she stayed whole — five practices anyone can borrow' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'subtitle', 3, LAST_INSERT_ID());

-- Component 4 for Card 5
INSERT INTO component_text (content) VALUES ('When you carry a reason that matters more than your fear, fear becomes one feeling among many — not the one in charge. Kadeer’s reason was not abstract. It was specific people: Uyghur women, Uyghur children, her own family. Specific, named purposes are stronger than vague ones. ‘I want to make the world better’ is too big to hold onto in a hard moment. ‘I am doing this for [these specific people]’ holds.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How she stayed whole — five practices anyone can borrow' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 5
INSERT INTO component_subtitle (content) VALUES ('2. She refused to disappear into bitterness');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How she stayed whole — five practices anyone can borrow' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'subtitle', 5, LAST_INSERT_ID());

-- Component 6 for Card 5
INSERT INTO component_text (content) VALUES ('After prison, exile, and the suffering of her family, she kept speaking peacefully — through international institutions, through journalism, through testimony. She has consistently advocated non-violent advocacy. Bitterness shrinks you; a clear cause keeps you upright. There is a psychological reason for this: bitterness ties your nervous system to the person who hurt you. Purpose ties it to the people you are protecting. The second is sustainable; the first is not.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How she stayed whole — five practices anyone can borrow' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'text', 6, LAST_INSERT_ID());

-- Component 7 for Card 5
INSERT INTO component_subtitle (content) VALUES ('3. She did not separate ‘mother’ from ‘leader’');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How she stayed whole — five practices anyone can borrow' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'subtitle', 7, LAST_INSERT_ID());

-- Component 8 for Card 5
INSERT INTO component_text (content) VALUES ('She was a mother of eleven and a public figure at the same time. Many women feel forced to choose — career or family, ambition or care. Kadeer’s life suggests another framing. Her family was not a competing identity. It was the source of her courage. The women she fought for were, in a real sense, an extension of the same care she gave her children. You do not have to amputate one part of yourself to be strong in another.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How she stayed whole — five practices anyone can borrow' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'text', 8, LAST_INSERT_ID());

-- Component 9 for Card 5
INSERT INTO component_subtitle (content) VALUES ('4. She accepted that strength has a price, and paid it consciously');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How she stayed whole — five practices anyone can borrow' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'subtitle', 9, LAST_INSERT_ID());

-- Component 10 for Card 5
INSERT INTO component_text (content) VALUES ('She did not pretend the cost was small. In her autobiography and interviews, she has spoken openly about her grief, her fear, the weight of her children’s suffering. She did not perform invulnerability. She decided the cost was bearable because the alternative — silence — was worse. This is a very specific kind of strength: not denial, but conscious payment. You can borrow this frame for any hard decision. Don’t pretend it doesn’t hurt. Decide the alternative would hurt more.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How she stayed whole — five practices anyone can borrow' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'text', 10, LAST_INSERT_ID());

-- Component 11 for Card 5
INSERT INTO component_subtitle (content) VALUES ('5. She kept her dignity as a daily practice');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How she stayed whole — five practices anyone can borrow' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'subtitle', 11, LAST_INSERT_ID());

-- Component 12 for Card 5
INSERT INTO component_text (content) VALUES ('Witnesses describe her as composed, soft-spoken and clear, even in moments of huge pressure. Dignity, for her, was not a personality trait — it was something she chose every morning. The headscarf she wore in public, the calm pace of her speech, the refusal to shout back at hostile questions: these were daily practices. You do not need to feel composed to act composed. Acting composed reliably produces feeling composed, after a few minutes.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How she stayed whole — five practices anyone can borrow' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'text', 12, LAST_INSERT_ID());

-- Component 13 for Card 5
INSERT INTO component_quote (content, author) VALUES ('Strength is not the absence of fear. It is the practice of not letting fear decide what you do next.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How she stayed whole — five practices anyone can borrow' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'quote', 13, LAST_INSERT_ID());

-- Component 14 for Card 5
INSERT INTO component_mcq (question) VALUES ('Looking at Kadeer’s five practices, which is closest to what real strength under pressure actually means?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Looking at Kadeer’s five practices, which is closest to what real strength under pressure actually means?' ORDER BY id DESC LIMIT 1), 'Never feeling afraid, never feeling tired, and never doubting yourself.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Looking at Kadeer’s five practices, which is closest to what real strength under pressure actually means?' ORDER BY id DESC LIMIT 1), 'Holding onto something larger than your fear — a specific purpose, specific people, daily small choices — and acting from there even when you are afraid.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Looking at Kadeer’s five practices, which is closest to what real strength under pressure actually means?' ORDER BY id DESC LIMIT 1), 'Becoming hard, distant and emotionless so that nothing can hurt you.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How she stayed whole — five practices anyone can borrow' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'mcq', 14, LAST_INSERT_ID());

-- Component 15 for Card 5
INSERT INTO component_open_questions (question) VALUES ('Of the five practices above, which one would help you most with a hard situation in your own life right now? Write down which one and why, in 2–3 sentences.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How she stayed whole — five practices anyone can borrow' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'open question', 15, LAST_INSERT_ID());

-- Component 16 for Card 5
INSERT INTO component_last_messages (content) VALUES ('She did not have a secret. She had a small handful of practices she repeated for fifty years. That is the actual shape of strength.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How she stayed whole — five practices anyone can borrow' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'last message', 16, LAST_INSERT_ID());

-- ============================================
-- Card 6
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure'), 6, 'Your own pressure, your own size', 'Translating it into your own life', NULL, NULL);

-- Component 1 for Card 6
INSERT INTO component_title (content) VALUES ('Your own pressure, your own size');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your own pressure, your own size' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 6
INSERT INTO component_text (content) VALUES ('Most of us will never be a millionaire turned political prisoner. But every woman lives under pressure of her own — workplace dynamics, family expectations, financial weight, cultural constraints, the slow grind of being underestimated. The point of looking at a life as large as Kadeer’s is not to feel small by comparison. It is to borrow the principles she used at her scale and apply them at yours.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your own pressure, your own size' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 6
INSERT INTO component_subtitle (content) VALUES ('What you’ve seen across these five cards');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your own pressure, your own size' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'subtitle', 3, LAST_INSERT_ID());

-- Component 4 for Card 6
INSERT INTO component_quote (content, author) VALUES ('You don’t need her life. You just need to borrow how she carried hers.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your own pressure, your own size' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'quote', 4, LAST_INSERT_ID());

-- Component 5 for Card 6
INSERT INTO component_subtitle (content) VALUES ('Translating it into your own life');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your own pressure, your own size' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'subtitle', 5, LAST_INSERT_ID());

-- Component 6 for Card 6
INSERT INTO component_text (content) VALUES ('Pressure in your life will look different — a difficult colleague, a controlling family member, a burnout no one is noticing, a community that expects you to stay quiet. The translation is not complicated. Identify the specific people you are doing this for. Choose clarity over bitterness in how you respond. Refuse to split your roles into competing identities. Accept that staying yourself will sometimes cost something. Practice dignity in small daily moments — even when you do not feel like it, especially when you do not feel like it.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your own pressure, your own size' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'text', 6, LAST_INSERT_ID());

-- Component 7 for Card 6
INSERT INTO component_mcq (question) VALUES ('Pick one practice you want to apply this week, in your own life and your own size.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Pick one practice you want to apply this week, in your own life and your own size.' ORDER BY id DESC LIMIT 1), 'Name the specific people my purpose is for, instead of staying vague.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Pick one practice you want to apply this week, in your own life and your own size.' ORDER BY id DESC LIMIT 1), 'Replace one bitter response with a clear one in a difficult conversation.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Pick one practice you want to apply this week, in your own life and your own size.' ORDER BY id DESC LIMIT 1), 'Practice composure in one specific moment where I usually lose it (a meeting, a family dynamic, a hard message).');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your own pressure, your own size' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'mcq', 7, LAST_INSERT_ID());

-- Component 8 for Card 6
INSERT INTO component_open_questions (question) VALUES ('Write one sentence: ‘This week, I will [chosen practice] in [specific situation] by doing [the small first action].’ Keep it small enough that you can actually keep the promise.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your own pressure, your own size' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'open question', 8, LAST_INSERT_ID());

-- Component 9 for Card 6
INSERT INTO component_last_messages (content) VALUES ('Rebiya Kadeer did not become strong because of who she was. She became strong because of what she practiced, every day, for decades. That is something any woman, in any situation, can begin today.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your own pressure, your own size' AND owner_id = (SELECT id FROM module WHERE title = 'Day 5: Rebiya Kadeer — Staying Strong Under Pressure') LIMIT 1), 'last message', 9, LAST_INSERT_ID());

-- ============================================
-- End of generated queries
-- ============================================
