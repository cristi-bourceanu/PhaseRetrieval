# Phase Retrieval Algorithm

Ultra fast computation of Gerchberg-Saxton algorithm and other similar phase retrieval algorithm, using CUDA.
### Features:
1. Image
- Image Creation:
  - Illumination pattern
  - Desired pattern
- Image show in COLORMAP of phase,illumination pattern, desired pattern and actual output.
2. Solver
- Mathematical opperation blocks using CUDA:
  - Compose: Create complex signal from amplitude and phase
  - Decompose: Find amplitude and phase of a complex signal
  - SLM_To_Obj: FFT => Projection in image plane
  - Obj_To_Obj: IFFT => Projection from image plane to SLM plane (exit pupils plane multiplied by constant phase term)
  - Normalize: <img src="https://render.githubusercontent.com/render/math?math=u_{norm}=(u-u_{min})/(u_{max}-u_{min})"> <a href="https://www.codecogs.com/eqnedit.php?latex=u_{norm}=(u-u_{min})/(u_{max}-u_{min})" target="_blank"><img src="https://latex.codecogs.com/gif.latex?u_{norm}=(u-u_{min})/(u_{max}-u_{min})" title="u_{norm}=(u-u_{min})/(u_{max}-u_{min})" /></a>
- Call Algorithm to iterate
3. Algorithm
- Factory method to choose an algorithm to solve the problem. Implemented algorithm:
  - Gerchberg Saxton
  - Wang's Algorithm
  - MRAF
  - Fineup Hybrid Input-Output
