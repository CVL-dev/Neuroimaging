from __main__ import qt, ctk, slicer
import os
import math

from EMSegmentStep import *
from Helper import *
from LabelStatistics import LabelStatisticsWidget

class EMSegmentLabelStatisticsStep( EMSegmentStep ) :

  def __init__( self, stepid ):
    self.initialize( stepid )
    self.setName( 'Segmentation finished' )
    self.setDescription( 'View after-segmentation statistics.' )

    self.__updating = 0;


  def createUserInterface( self ):
    '''
    '''
    self.__layout = super( EMSegmentLabelStatisticsStep, self ).createUserInterface()

    infoLabel = qt.QLabel( 'The segmentation finished!\n\nThe results are displayed as labelMaps in the slice viewers.\n\n' )
    infoLabel.setFont( self.getBoldFont() )
    self.__layout.addWidget( infoLabel )

    self.__top = qt.QGroupBox()
    self.__top.setTitle( 'Statistics' )
    self.__top.toolTip = 'This table shows label statistics for the segmentation results.'
    self.__topLayout = qt.QVBoxLayout( self.__top )

    self.__layout.addWidget( self.__top )

    # deactivate next button since it is the last step
    # note that if simple mode is once called then it will always hide it - create a flag ! 
    if slicer.modules.emsegmentsimplemode:
      self.buttonBoxHints = self.ButtonBoxHidden
    else:
      self.buttonBoxHints = self.NextButtonDisabled

    # the volume node
    workingDataNode = self.mrmlManager().GetWorkingDataNode()

    if workingDataNode:
      # set flags in the mrml nodes
      workingDataNode.SetAlignedTargetNodeIsValid( 1 )
      workingDataNode.SetAlignedAtlasNodeIsValid( 1 )

      # show preprocessing output in sliceViews
      volumeCollection = workingDataNode.GetInputTargetNode()
      if volumeCollection:
        outputNode = volumeCollection.GetNthVolumeNode( 0 )

    labelStatisticsWidget = LabelStatisticsWidget( self.__top )
    labelStatisticsWidget.setup()
    labelStatisticsWidget.labelNode = self.mrmlManager().GetOutputVolumeNode()
    labelStatisticsWidget.grayscaleNode = outputNode

    labelStatisticsWidget.applyButton.visible = False
    labelStatisticsWidget.labelSelectorFrame.visible = False
    labelStatisticsWidget.grayscaleSelectorFrame.visible = False
    labelStatisticsWidget.saveButton.visible = False
    labelStatisticsWidget.grayscaleSelector.visible = False
    labelStatisticsWidget.labelSelector.visible = False

    labelStatisticsWidget.onApply()

    #if slicer.modules.emsegmentsimplemode:
    # infoLabel2 = qt.QLabel( '\n\nIt is now possible to reset the module.' )
    #infoLabel2.setFont( self.getBoldFont() )
    # self.__layout.addWidget( infoLabel2 )

    resetButton = qt.QPushButton( 'Reset Module' )
    resetButton.connect( 'clicked()', self.onResetButton )
    self.__layout.addWidget( resetButton )

  def onResetButton( self ):
    '''
    '''
    
    self.workflow().stop()
    self.workflow().start()

  def onEntry( self, comingFrom, transitionType ):
    '''
    '''
    super( EMSegmentLabelStatisticsStep, self ).onEntry( comingFrom, transitionType )

    self.loadFromMRML()


  def validate( self, desiredBranchId ):
    '''
    '''
    super( EMSegmentLabelStatisticsStep, self ).validate( desiredBranchId )

    self.validationSucceeded( desiredBranchId )



  def propagateToMRML( self ):
    '''
    '''
    if not self.__updating:

      self.__updating = 1


      self.__updating = 0


  def loadFromMRML( self ):
    '''
    '''
    if not self.__updating:

      self.__updating = 1

      self.__updating = 0



