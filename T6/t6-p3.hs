import Text.Printf
import System.Random

type Point = (Float,Float)
type Rect = (Point,Float,Float)

writeRect :: (String,Rect) -> String 
writeRect (style,((x,y),w,h)) = 
  printf "<rect x='%.3f' y='%.3f' width='%.2f' height='%.2f' transform='rotate(45 %.3f %.3f)' style='%s' />\n" x y w h x y style

writeRects :: Float -> Float -> [(String,Rect)] -> String
writeRects w h rs = printf "<svg width='%.2f' height='%.2f' xmlns='http://www.w3.org/2000/svg'>\n" w h 
                    ++ (concatMap writeRect rs) ++ "</svg>"

rand :: (RandomGen g) => g -> [Float]
rand gen = (randomRs(0,360) gen)

take' :: (Num i, Ord i) => i -> [a] -> [a]
take' _[] = []
take' n (x:xs) = x : take' (n-1) xs

main :: IO ()
main = do
  g <- newStdGen
  let
    width = 40
    lines = 10
    columns = 20
    (w,h) = (sqrt(width*width*2) * columns, sqrt(width*width*2) * lines)
    elem_list = [(line, column)| line <- [1..lines], column <- [1..columns]]
    coor_list = map (\n-> ( (sqrt(width*width*2))/2+(snd n - 1)*(sqrt(width*width*2)), 
                    (fst n - 1)*(sqrt(width*width*2)))) elem_list
    style_list = take' (lines*columns) (rand g)
    style = map (\n-> "fill:hsl(" ++ show n ++ ",100%,50%)") style_list
    zipped = zip style coor_list
    rects = map (\n-> (fst n, (snd n, width, width) ) ) zipped
  writeFile "colors.svg" (writeRects w h rects)