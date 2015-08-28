eleva2 :: [Int] -> [Int]
eleva2 [] = []
eleva2 lst = (head lst) ^ 2 : eleva2 (tail lst)

contido :: Char -> [Char] -> Bool
contido _ [] = False
contido x lst = if (head lst == x) then True else contido x (tail lst)

semVogais :: [Char] -> [Char]
semVogais [] = []
semVogais lst = if(elem (head lst) "aeiouAEIOU") then semVogais (tail lst) else head lst : semVogais (tail lst)

translate :: [(Double, Double)] -> [(Double, Double)]
translate [] =  []
translate ltuple = (fst (head ltuple) + 2, snd (head ltuple) + 2) : translate (tail ltuple)

geraTabela' :: Int -> [(Int, Int)]
geraTabela' 0 = []
geraTabela' x = geraTabela' (x - 1) ++ [(x, x^2)]