import numpy as np
from math import log, e

def sma(S3axis):
    """
    Signal magnitude area
  
    Parameters:
    S3axis: Series with 3 axis
  
    Returns:
    float: Signal magnitude area of 3 axis Series
  
    """
    return np.sum(S3axis) / S3axis.shape[0]

def energy(S1axis):
    """
    Energy measure. Sum of the squares divided by the number of values. 
  
    Parameters:
    S1axis: Series with 1 axis
  
    Returns:
    float: Energy of 1 axis Series
  
    """
    return np.sum(np.power(S1axis, 2)) / S1axis.shape[0]

def iqr(S1axis):
    """
    Interquartile range 
  
    Parameters:
    S1axis: Series with 1 axis
  
    Returns:
    float: Interquartile range of 1 axis Series
  
    """
    return np.subtract(*np.percentile(S1axis, [75, 25]))

def entropy(S1axis, base=None):
    """
    Signal entropy
  
    Parameters:
    S1axis: Series with 1 axis
  
    Returns:
    float: Entropy of 1 axis Series
  
    """
    n = len(S1axis)
    if n <= 1:  return 0
    val, count = np.unique(S1axis, return_counts=True)
    probs = count / n
    n_classes = np.count_nonzero(probs)
    if n_classes <= 1:  return 0
    ent = 0
    # compute entropy
    base = e if base is None else base
    for i in probs:
        ent -= i * log(i, base)
    return ent

def correlation(S1axis_1, S1axis_2):
    """
        Correlation coefficient between two signals

        Parameters:
        S1axis_1: Series with 1 axis
        S1axis_2: Series with 1 axis

        Returns:
        float: Correlation coefficient between two signals

    """
    return np.correlate(S1axis_1, S1axis_2)

def maxInd(S1axis):
    """
        Index of the frequency component with largest magnitude

        Parameters:
        S1axis: Series with 1 axis

        Returns:
        float: Index of the frequency component with largest magnitude
    """
    return np.argmax(S1axis)
