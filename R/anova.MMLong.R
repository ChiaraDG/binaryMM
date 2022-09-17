#' Comparing Two Models: ANOVA
#'
#' Compute analysis of variance tables for two fitted model objects
#' @param object a list with two elements. Element 1 is the first model fit using \code{mm}, element 2 is the second model fit using \code{mm}
#' @param ... additional control variables
#'
#' @return ANOVA table
#' @export
#'
#' @examples
anova.MMLong <-
function(object, ...) {
  oo1 = object
  oo2 = list(...)[[1]]

  #mod1 = list(mf=oo1$m.formula, tf=oo1$t.formula, lvf=oo1$lv.formula)
  #mod2 = list(mf=oo2$m.formula, tf=oo2$t.formula, lvf=oo2$lv.formula)

  mod1 = list(mf=oo1$call)
  mod2 = list(mf=oo2$call)

  #if(!identical(mod1[2:3],mod2[2:3])) {
  #  print('Warning: Association models differ!')
  #}

  info.mat = rbind(oo1$info_stats, oo2$info_stats)
  info.mat = data.frame(cbind(df=c(nrow(oo1$mod.cov),nrow(oo2$mod.cov)), info.mat))
  ord = sort(info.mat$Deviance,index.return=TRUE, decreasing=TRUE)$ix
  info.mat = info.mat[ord,]
  info.mat$ChiSq = c(NA,-diff(info.mat$Deviance))
  info.mat$ChiSqdf = c(NA,diff(info.mat$df))
  info.mat$p = c(NA,pchisq(info.mat$ChiSq[2], df=info.mat$ChiSqdf[2],lower.tail=FALSE))
  names(info.mat) = c('df','AIC','BIC','logLik','Deviance','Chi Square','Chi Square df','Pr(>Chi)')
  rownames(info.mat) = c('Model 1','Model 2')
  mod1.nm = mod1[!unlist(lapply(mod1,is.null))]
  mod2.nm = mod2[!unlist(lapply(mod2,is.null))]
  mod1.nm = paste(paste(names(mod1.nm),'(', mod1.nm, ')',sep=''),collapse=' + ')
  mod2.nm = paste(paste(names(mod2.nm),'(', mod2.nm, ')',sep=''),collapse=' + ')
  nms     = c(mod1.nm, mod2.nm)[ord]
  out = list(atable = info.mat, models=nms)
  class(out) = 'anova.MMLong'
  out
}
