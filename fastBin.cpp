
/* fastOPD.cpp, R Miyakawa, 11/2013
 *
 * OPD = fastOPD(Xcoords, Ycoords, z1_um, z2_um, lambda_um, T_um, orders);
 * 
 * Computes the OPD from the self-interference of a wave incident on a 
 * defocused grating in an LSI experiment.  This function can be used to study
 * the systematic aberrations associated with using a grating at high numerical
 * apertures.  While this result is not perfectly analytical, it can be 
 * solved numerically much more quickly than running a simulation.
 *
 * Here Xcoords and Ycoords are arrays containing the detector coordinates.
 *
 * Orders is a 1x2 array specifying which 2 grating orders are interfering
 * e.g., [1, -1] specifies that its the +/- 1 orders that are interfering.
 *
 */


#include <stdio.h>
#include <mex.h>
#include <math.h>






// Main function: generates an array of coordinates of trapezoids representing
// the desired zoneplate. A pointer to the 2D array is returned
void bin1D(double * in, double * out, int nRow, int nCol, int binRow ){

    for (int k = 0; k < binRow*binCol; k += binCol){
        for (int m = 
    for (int k = 0; k < binRow*binCol; k++){
        out[k] = 0;
    }
    
}

// Gatway function for MATLAB interface
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) 
{
  
    double * in; 
    
    in = mxGetPr(prhs[0]);

    int binRow       = (int)(mxGetScalar(prhs[1]));
    int binCol       = (int)(mxGetScalar(prhs[2]));
    
    int nRow         = (int) mxGetM(prhs[0]);
    int nCol        = (int) mxGetN(prhs[0]);
    
    printf("nrow is %d, ncol = %d, binRows is %d, binCols is %d \n", nRow, nCol, binRow, binCol);

    
    double * oneDbin = mxGetPr(mxCreateDoubleMatrix(binRow, nCol, mxREAL));
    bin1D(in, oneDbin, nRow, nCol, binRow);
    
    plhs[0]         = mxCreateDoubleMatrix(binRow, binCol, mxREAL);
    double * out    = mxGetPr(plhs[0]);

    bin(in, out, nRow, nCol, binRow, binCol);
    
}
