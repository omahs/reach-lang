module Reach.Dotty
  ( DotGraph
  , DotEdge
  , dotty
  ) where

import qualified Data.Map.Strict as M
import Reach.Texty

type DotEdge = (String, String, M.Map String String)
type DotGraph = [DotEdge]

newtype DotGraph_ = DotGraph_ DotGraph
instance Pretty DotGraph_ where
  pretty (DotGraph_ es) = dotty es

dotty :: DotGraph -> Doc
dotty es = vsep $ [preamble, "digraph {"] <> map go es <> ["}"]
  where
    preamble = "// This file is in the DOT file format. Upload or copy it into a Graphviz engine, such as https://dreampuf.github.io/GraphvizOnline"
    go (f, t, am) = viaShow f <> "->" <> viaShow t <> "[" <> a' <> "]"
      where
        a' = hcat $ punctuate "," $ map (\(k, v) -> pretty k <> "=" <> pretty v) $ M.toAscList am


