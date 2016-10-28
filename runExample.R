#' Run examples in packages
#'
#' @importFrom rmarkdown render
#' @importFrom rmarkdown run
#' 
#' @param pkg [\code{character}] An installed package
#' @param preview.files [\code{logical}] If \code{TRUE}, a numbered list of available examples is returned 
#' @param which [\code{numerical}] Which example should be run? 
#' @param output [\code{character}] File extension of the output file
#' @param shiny [\code{logical}] If example contains shiny content, \code{TRUE}
#' 
#' @description This function retreives examples stored in the Examples folder for installed packages.
#' 
#' @export

runExample <- function(pkg, preview.files = TRUE, which = NULL, output = 'html', shiny = FALSE) {
  
  exps <- list.files(system.file("examples", package = pkg))
  
  if(length(exps)==0) stop(paste(c('Package', pkg, 'does not have any examples'),
                               collapse = ' '))
  
  if(preview.files) { data.frame(exps)
    
  } else { 
  
  file <- eval(
          substitute(
            system.file('examples', 
                        a, 
                        package = pkg), list(a = exps[which])))

  if(!shiny) {
    
  rmarkdown::render(file, output_dir = getwd())
  
  output <- gsub('\\.', '', tolower(output))
  
  system2('open', gsub('.Rmd', paste(c('.',output), collapse = ''), exps[which]))
  
  } else {
    
    rmarkdown::run(file)
    
  }
  }
}
