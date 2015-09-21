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

writeRect2 :: (String,Rect) -> String 
writeRect2 (style,((x,y),w,h)) = 
  printf "<rect x='%.3f' y='%.3f' width='%.2f' height='%.2f' style='%s' />\n" x y w h style

writeRects2 :: Float -> Float -> [(String,Rect)] -> String
writeRects2 w h rs = printf "<svg width='%.2f' height='%.2f' xmlns='http://www.w3.org/2000/svg'>\n" w h 
                    ++ (concatMap writeRect2 rs) ++ "</svg>"

rand :: (RandomGen g) => g -> [Float]
rand gen = (randomRs(0,360) gen)

take' :: (Num i, Ord i) => i -> [a] -> [a]
take' _[] = []
take' n (x:xs) = x : take' (n-1) xs

main1 :: IO ()
main1 = do
  g <- newStdGen
  let
    width = 5
    lines = 90
    columns = 190
    (w,h) = (sqrt(width*width*2) * columns, sqrt(width*width*2) * lines)
    elem_list = [(line, column)| line <- [1..lines], column <- [1..columns]]
    coor_list = map (\n-> ( (sqrt(width*width*2))/2+(snd n - 1)*(sqrt(width*width*2)), 
                    (fst n - 1)*(sqrt(width*width*2)))) elem_list
    style_list = take' (lines*columns) (rand g)
    style = map (\n-> "fill:hsl(" ++ show n ++ ",100%,50%)") style_list
    zipped = zip style coor_list
    rects = map (\n-> (fst n, (snd n, width, width) ) ) zipped
  writeFile "colors.svg" (writeRects w h rects)

main2 :: IO ()
main2 = do
  let
    quantity = 70
    width = 1000
    height = 700
    wid_list = [width*(0.9^(wid-1)) | wid <- [1..quantity]]
    hei_list = [height*(0.9^(hei-1)) | hei <- [1..quantity]]
    x_list = map (\n-> (width - n)/2) wid_list
    y_list = map (\n-> (height - n)/2) hei_list
    style_list = [if (mod x 2) == 1 then "fill:black" else "fill:white"| x<-[1..quantity]]
    dim_zip = zip wid_list hei_list
    coor_zip = zip x_list y_list
    dim_coor = zip dim_zip coor_zip
    zipped = zip dim_coor style_list
    rects = map (\n-> (snd n, ((fst (snd (fst n)), snd (snd (fst n))), fst (fst (fst n)), snd (fst (fst n))))) zipped
  writeFile "colors.svg" (writeRects2 width height rects)