module Text.Email.Aeson.Instances where
import           Control.Monad       (mzero)
import           Data.Aeson
import qualified Data.Text.Encoding  as TS
import qualified Text.Email.Validate as TEV

instance ToJSON TEV.EmailAddress where
  toJSON = String . TS.decodeUtf8 . TEV.toByteString

instance FromJSON TEV.EmailAddress where
  parseJSON (String s) = case TEV.emailAddress (TS.encodeUtf8 s) of
    Nothing -> mzero
    Just x -> return x
  parseJSON _ = mzero
