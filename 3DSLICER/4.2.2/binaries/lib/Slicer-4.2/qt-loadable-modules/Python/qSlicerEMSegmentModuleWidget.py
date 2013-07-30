from __main__ import vtk, qt, ctk, slicer

import EMSegmentWizard
from EMSegmentWizard import Helper

class qSlicerEMSegmentModuleWidget:
  def __init__( self, parent=None ):
    if not parent:
      self.parent = slicer.qMRMLWidget()
      self.parent.setLayout( qt.QVBoxLayout() )
    else:
      self.parent = parent

    self.layout = self.parent.layout()

    # this flag is 1 if there is an update in progress
    self.__updating = 1

    # Reference to the logic
    self.__logic = None

    if not parent:
      self.__logic = slicer.modulelogic.vtkEMSegmentLogic()
      self.setup()
      self.parent.setMRMLScene( slicer.mrmlScene )
      # after setup, be ready for events
      self.__updating = 0

      self.parent.show()


  def setup( self ):
    '''
    Create and start the EMSegment workflow.
    '''

    # Use the logic associated with the module
    if not self.__logic:
      self.__logic = self.parent.module().logic()

    self.parent.connect('mrmlSceneChanged(vtkMRMLScene*)', self.onMRMLSceneChanged)

    workflow = ctk.ctkWorkflow()

    workflowWidget = ctk.ctkWorkflowStackedWidget()
    workflowWidget.setWorkflow( workflow )

    workflowWidget.buttonBoxWidget().nextButtonDefaultText = ""
    workflowWidget.buttonBoxWidget().backButtonDefaultText = ""

    # create all wizard steps
    selectTaskStep = EMSegmentWizard.EMSegmentSelectTaskStep( Helper.GetNthStepId( 1 ) )
    defineInputChannelsSimpleStep = EMSegmentWizard.EMSegmentDefineInputChannelsStep( Helper.GetNthStepId( 2 ) + 'Simple' ) # simple branch
    defineInputChannelsAdvancedStep = EMSegmentWizard.EMSegmentDefineInputChannelsStep( Helper.GetNthStepId( 2 ) + 'Advanced' ) # advanced branch
    defineAnatomicalTreeStep = EMSegmentWizard.EMSegmentDefineAnatomicalTreeStep( Helper.GetNthStepId( 3 ) )
    defineAtlasStep = EMSegmentWizard.EMSegmentDefineAtlasStep( Helper.GetNthStepId( 4 ) )
    editRegistrationParametersStep = EMSegmentWizard.EMSegmentEditRegistrationParametersStep( Helper.GetNthStepId( 5 ) )
    definePreprocessingStep = EMSegmentWizard.EMSegmentDefinePreprocessingStep( Helper.GetNthStepId( 6 ) )
    specifyIntensityDistributionStep = EMSegmentWizard.EMSegmentSpecifyIntensityDistributionStep( Helper.GetNthStepId( 7 ) )
    editNodeBasedParametersStep = EMSegmentWizard.EMSegmentEditNodeBasedParametersStep( Helper.GetNthStepId( 8 ) )
    miscStep = EMSegmentWizard.EMSegmentDefineMiscParametersStep( Helper.GetNthStepId( 9 ) )
    segmentStep = EMSegmentWizard.EMSegmentStartSegmentationStep( Helper.GetNthStepId( 10 ) )
    statisticsStep = EMSegmentWizard.EMSegmentLabelStatisticsStep( Helper.GetNthStepId( 11 ) )


    # add the wizard steps to an array for convenience
    allSteps = []

    allSteps.append( selectTaskStep )
    allSteps.append( defineInputChannelsSimpleStep )
    allSteps.append( defineInputChannelsAdvancedStep )
    allSteps.append( defineAnatomicalTreeStep )
    allSteps.append( defineAtlasStep )
    allSteps.append( editRegistrationParametersStep )
    allSteps.append( definePreprocessingStep )
    allSteps.append( specifyIntensityDistributionStep )
    allSteps.append( editNodeBasedParametersStep )
    allSteps.append( miscStep )
    allSteps.append( statisticsStep )
    allSteps.append( segmentStep )

    # Add transition for the first step which let's the user choose between simple and advanced mode
    workflow.addTransition( selectTaskStep, defineInputChannelsSimpleStep, 'SimpleMode' )
    workflow.addTransition( selectTaskStep, defineInputChannelsAdvancedStep, 'AdvancedMode' )

    # Add transitions associated to the simple mode
    workflow.addTransition( defineInputChannelsSimpleStep, defineAnatomicalTreeStep )

    # Add transitions associated to the advanced mode
    workflow.addTransition( defineInputChannelsAdvancedStep, defineAnatomicalTreeStep )

    # .. add transitions for the rest of the advanced mode steps
    for i in range( 3, len( allSteps ) - 1 ):
      workflow.addTransition( allSteps[i], allSteps[i + 1] )

    # Propagate the workflow, the logic and the MRML Manager to the steps
    for s in allSteps:
      s.setLogic( self.__logic )
      s.setMRMLManager( self.__logic.GetMRMLManager() )

    # Disable the error text which showed up when jumping to the (invisible) segment step
    workflowWidget.workflowGroupBox().errorTextEnabled = False
    workflow.goBackToOriginStepUponSuccess = False

    # start the workflow and show the widget
    workflow.start()
    workflowWidget.visible = True
    self.layout.addWidget( workflowWidget )

    # enable global access to the dynamicFrames on step 2 and step 6
    slicer.modules.emsegmentLogic = self.__logic
    slicer.modules.emsegmentSimpleDynamicFrame = defineInputChannelsSimpleStep.dynamicFrame()
    slicer.modules.emsegmentPreprocessingStep = definePreprocessingStep

    # Keep track of workflow and workflowWidget references
    self.__workflow = workflow
    self.__workflowWidget = workflowWidget

  def onMRMLSceneChanged(self, mrmlScene):
    if mrmlScene != self.__logic.GetMRMLScene():
      self.__logic.SetMRMLScene(mrmlScene)
      self.__logic.RegisterNodes()
      self.__logic.InitializeEventListeners()
    self.__logic.GetMRMLManager().SetMRMLScene(mrmlScene)

  def GetDynamicFrame( self ):
    '''
    '''
    return EMSegmentWizard.EMSegmentDynamicFrame()
