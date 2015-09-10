addSuffix :: String -> [String] -> [String]
addSuffix suffix list = [x++suffix | x<-list]

addSuffixR :: String -> [String] -> [String]
addSuffixR _[] = []
addSuffixR suffix list = (head(list)++suffix):addSuffixR suffix (tail(list))

countShorts :: [String] -> Int
countShorts [] = 0
countShorts list = if(length(head(list)) >= 5) then 1 + countShorts(tail(list)) else countShorts(tail(list))

countShortsLC :: [String] -> Int
countShortsLC list = length [x | x<-list, (length x)<5]

ciclo :: Int -> [Int] -> [Int]
ciclo 0 _ = []
ciclo x list = list ++ ciclo (x-1) list

combine :: [Int] -> [String] -> [(Int,String)]
combine _ [] = []
combine [] _ = []
combine list1 list2 = (head list1, head list2) : combine (tail list1) (tail list2)

numera :: [String] -> [(Int,String)]
numera = numera' 1

numera' :: Int -> [String] -> [(Int, String)]
numera' _[] = []
numera' x lst = (x, head lst) : numera' (x + 1) (tail lst)

{-
Senpai> [ (x,y) | x <- [1..5], even x, y <- [(x + 1)..6], odd y]
[(2,3),(2,5),(4,5)]

Essa expressão retorna uma lista de tulpas gerada a partir dos valores pares da lista 
x - [2,4] - e de uma lista y de números ímpares entre x e 6 - de 2 a 6 
temos [3,5] e de 4 a 6 temos [5]. Disso se formam os 3 pares (2,3), (2,5) e (4,5)

Senpai> [ a ++ b | a <- ["lazy", "big"], b <- ["frog", "dog"]]
["lazyfrog","lazydog","bigfrog","bigdog"]

Essa expressão concatena todos os elementos da primeira lista com os da segunda

Senpai> concat [ [a, '-'] | a <- "paralelepipedo", a `elem` "aeiou"]
"a-a-e-e-i-e-o-"

Essa expressão pega todas as vogais da palavra paralelepipedo e gera várias listas
formadas pela vogal e um hífen. Essas listas são concatenadas e geram uma string única
-}

crossProduct :: [a] -> [b] -> [(a,b)]
crossProduct []_ = []
crossProduct xs ys = (pairWithAll (head xs) ys) ++ crossProduct (tail xs) ys

pairWithAll :: a -> [b] -> [(a,b)]
pairWithAll _[] = []
pairWithAll elem ys = (elem,head ys) : pairWithAll elem (tail ys)

genRects :: Int -> (Int,Int) -> [(Float,Float,Float,Float)]
genRects x coord = genRects' x (fromIntegral (fst coord), fromIntegral (snd coord))

genRects' :: Int -> (Float,Float) ->[(Float,Float,Float,Float)]
genRects' 0_ = []
genRects' x coord = (fst coord, snd coord, 5.5, 5.5) : genRects' (x-1) (fst coord + 5.5, snd coord)

func11 :: [(Int,Int)] -> ([Int],[Int])
func11 [] = ([],[])
func11 (x:xs) = (fst x:(fst (func11 xs)), snd x: (snd (func11 xs)))

func12 :: [(Int,Int)] -> ([Int],[Int])
func12 list = ([fst x|x<-list],[snd x|x<-list])

func13 :: [(Int,Int)] -> ([Int],[Int])
func13 list = (map (\x-> fst(x)) list, map (\x-> snd(x)) list)