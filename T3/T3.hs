-- isEven :: Int -> Bool
-- isEven n = mod n 2 == 0

somaquad :: Int -> Int -> Int
somaquad x y = x ^ 2 + y ^ 2

doubleFirst :: [Int] -> Int
doubleFirst list = head list ^ 2

hasEqHeads :: [Int] -> [Int] -> Bool
hasEqHeads listA listB = head listA == head listB

addMr :: [[Char]] -> [[Char]]
addMr llist = map (\n -> "Mr. " ++ n) llist

spaceCount :: String-> Int
spaceCount list = length (filter (== ' ') list)

calculo :: [Double] ->[Double]
calculo list = map (\n -> 3 * n ^ 2 + 2 / n + 1) list

idades :: [Int] -> [Int]
idades list = filter (> (2015 - 1970)) list

serie :: Double -> [Double] -> Double
serie m n = sum (map (\n -> n/m) n)

charFound :: Char -> String -> Bool
charFound c list = 0 < length (filter (c ==) list)

htmlListItems :: [String] -> [String]
htmlListItems llist = map (\n -> "<LI>" ++ n ++ "</LI>") llist

-- > takeWhile (< 5) [1,2,3,4,5]
-- [1,2,3,4]
-- > takeWhile (/=' ') "Fulana de Tal"
-- "Fulana"
-- > takeWhile (even) [2,4,6,8,1,3,5,7,9]
-- [2,4,6,8]

filterName :: [[Char]] -> [[Char]]
filterName llist = filter (\n -> last n == 'a') llist