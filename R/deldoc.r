#' Delete a document in a database.
#'
#' @export
#' @inheritParams ping
#' @param dbname Database name. (charcter)
#' @param docid Document ID (character)
#' @examples \donttest{
#' doc3 <- "<top><a/><b/><c><d/><e>bob</e></c></top>"
#' writedoc(dbname="sofadb", doc=doc3, docid="newnewxml")
#' deldoc(dbname="sofadb", docid="newnewxml")
#'
#' # wrong docid name
#' writedoc(dbname="sofadb", doc=doc3, docid="newxml")
#' deldoc(dbname="sofadb", docid="wrongname")
#'
#' # remote
#' doc3 <- "<top><a/><b/><c><d/><e>bob</e></c></top>"
#' writedoc("cloudant", dbname="mustache", doc=doc3, docid="bbbb")
#' getdoc("cloudant", dbname='mustache', docid='bbbb')
#' deldoc("cloudant", dbname='mustache', docid='bbbb')
#' }
deldoc <- function(cushion="localhost", dbname, docid, ...)
{
  cushion <- get_cushion(cushion)
  revget <- getdoc(cushion, dbname, docid)[["_rev"]]
  if(cushion$type=="localhost"){
    sofa_DELETE(sprintf("http://127.0.0.1:%s/%s/%s", cushion$port, dbname, docid), query=list(rev=revget), ...)
  } else if(cushion$type %in% c("cloudant",'iriscouch')){
    sofa_DELETE(paste0(remote_url(cushion, dbname), docid), content_type_json(), query=list(rev=revget), ...)
  }
}
