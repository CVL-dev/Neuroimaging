from __main__ import vtk, qt, ctk, slicer

import EMSegmentWizard
from EMSegmentWizard import Helper

class qSlicerEMSegmentQuickModuleWidget:
  def __init__( self, parent=None ):
    if not parent:
      self.parent = slicer.qMRMLWidget()
      self.parent.setLayout( qt.QVBoxLayout() )
    else:
      self.parent = parent

    # this flag is 1 if there is an update in progress
    self.__updating = 1

    # the pointer to the logic and the mrmlManager
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

    # Create all wizard steps
    step1 = EMSegmentWizard.EMSegmentQuickStep1( Helper.GetNthStepId( 2 ) )
    step2 = EMSegmentWizard.EMSegmentQuickStep2( Helper.GetNthStepId( 3 ) )
    step3 = EMSegmentWizard.EMSegmentQuickStep3( Helper.GetNthStepId( 7 ) )
    step4 = EMSegmentWizard.EMSegmentQuickStep4( Helper.GetNthStepId( 9 ) )
    step5 = EMSegmentWizard.EMSegmentQuickStep5( Helper.GetNthStepId( 11 ) )
    segmentStep = EMSegmentWizard.EMSegmentQuickSegmentationStep( Helper.GetNthStepId( 10 ) )

    # Add the wizard steps to an array for convenience
    allSteps = []

    allSteps.append( step1 )
    allSteps.append( step2 )
    allSteps.append( step3 )
    allSteps.append( step4 )
    allSteps.append( step5 )
    allSteps.append( segmentStep )

    # Add transitions
    for i in range( 0, len( allSteps ) - 1 ):
      workflow.addTransition( allSteps[i], allSteps[i + 1] )

    # Propagate the workflow, the logic and the MRML Manager to the steps
    for s in allSteps:
      s.setLogic( self.__logic )
      s.setMRMLManager( self.__logic.GetMRMLManager() )

    # Disable the error text which showed up when jumping to the (invisible) segment step
    workflowWidget.workflowGroupBox().errorTextEnabled = False
    workflow.goBackToOriginStepUponSuccess = False

    slicer.modules.emsegmenteasystep1 = step1
    slicer.modules.emsegmenteasystep2 = step2

    # Start the workflow and show the widget
    workflow.start()
    workflowWidget.visible = True
    self.parent.layout().addWidget( workflowWidget )

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
