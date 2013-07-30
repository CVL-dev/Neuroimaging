import sys
import time

class Helper( object ):

  @staticmethod
  def GenericMessage( message, type = ""):
    if not type == "": type = " %s:" % type
    str_time = time.strftime( "%m/%d/%Y %H:%M:%S" )
    print "[EMSegmentPy %s]:%s %s" %(str_time, type, str(message))
    sys.stdout.flush()

  @staticmethod
  def Info( message ):
    Helper.GenericMessage(message)

  @staticmethod
  def Warning( message ):
    Helper.GenericMessage(message, "WARNING")

  @staticmethod
  def Error( message ):
    Helper.GenericMessage(message, "ERROR")

  @staticmethod
  def Debug( message ):
    showDebugOutput = 0
    if showDebugOutput:
      Helper.GenericMessage(message, "DEBUG")

  @staticmethod
  def CreateSpace( n ):
    spacer = ""
    for s in range( n ):
      spacer += " "
    return spacer

  @staticmethod
  def GetNthStepId( n ):
    steps = [None, # 0
             'SelectTask', # 1
             'DefineInputChannels', # 2
             'DefineAnatomicalTree', # 3
             'DefineAtlas', # 4
             'EditRegistrationParameters', # 5
             'DefinePreprocessing', # 6
             'SpecifyIntensityDistribution', # 7
             'EditNodeBasedParameters', # 8
             'DefineMiscParameters', # 9
             'Segment', # 10
             'Statistics'] # 11

    if n < 0 or n > len( steps ): n = 0
    return steps[n]

  @staticmethod
  def GetRegistrationTypes():
    return ['None', 'Fast', 'Accurate']

  @staticmethod
  def GetInterpolationTypes():
    return ['Linear', 'Nearest Neighbor', 'Cubic' ]

  @staticmethod
  def GetPackages():
    return ['CMTK', 'BRAINS', 'PLASTIMATCH', 'DEMONS', 'DRAMMS', 'ANTS']

  @staticmethod
  def GetSpecificationTypes():
    return ['Manual', 'Manual Sampling']#, 'Auto Sampling']

  @staticmethod
  def GetStoppingConditionTypes():
    return ['Iterations', 'LabelMap', 'Weights']

  @staticmethod
  def onClickInSliceView( sliceViewInteractorStyle, sliceLogic ):
    '''
    Get the last event of a certain sliceView and return it as RAS coordinates.
    '''
    coordinates = []

    i = sliceViewInteractorStyle.GetInteractor()
    if i:

      clickedPos = i.GetLastEventPosition()

      # we need a 4 element point to be able to multiply further down
      coordinates.append( clickedPos[0] )
      coordinates.append( clickedPos[1] )
      coordinates.append( 0 )
      coordinates.append( 1 )

      xyToRas = sliceLogic.GetSliceNode().GetXYToRAS()

      rasPos = xyToRas.MultiplyPoint( coordinates )

      return [rasPos[0], rasPos[1], rasPos[2]]
