% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/xmu.r
\name{xmu_dot_make_paths}
\alias{xmu_dot_make_paths}
\title{xmu_dot_make_paths (not for end users)}
\usage{
xmu_dot_make_paths(mxMat, stringIn, heads = NULL, showFixed = TRUE,
  comment = "More paths", showResiduals = TRUE, pathLabels = "labels",
  digits = 2)
}
\arguments{
\item{mxMat}{an MxMatrix}

\item{stringIn}{input string}

\item{heads}{1 or 2}

\item{showFixed}{to show fixed values or not}

\item{comment}{a comment to include}

\item{showResiduals}{Whether to show residuals}

\item{pathLabels}{labels}

\item{digits}{how many digits to report}
}
\value{
- string
}
\description{
xmu_dot_make_paths (not for end users)
}
\seealso{
Other xmu internal not for end user: \code{\link{xmuHasSquareBrackets}};
  \code{\link{xmuLabel_MATRIX_Model}};
  \code{\link{xmuLabel_Matrix}};
  \code{\link{xmuLabel_RAM_Model}}; \code{\link{xmuMI}};
  \code{\link{xmuMakeDeviationThresholdsMatrices}};
  \code{\link{xmuMakeOneHeadedPathsFromPathList}};
  \code{\link{xmuMakeTwoHeadedPathsFromPathList}};
  \code{\link{xmuMaxLevels}}; \code{\link{xmuMinLevels}};
  \code{\link{xmuPropagateLabels}};
  \code{\link{xmu_dot_make_residuals}};
  \code{\link{xmu_start_value_list}}
}
