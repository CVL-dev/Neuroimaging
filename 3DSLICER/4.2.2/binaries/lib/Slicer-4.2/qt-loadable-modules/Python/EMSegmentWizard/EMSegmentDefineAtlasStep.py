from __main__ import qt, ctk, slicer

from EMSegmentStep import *

class EMSegmentDefineAtlasStep( EMSegmentStep ) :

  def __init__( self, stepid ):
    self.initialize( stepid )
    self.setName( '4. Define Atlas' )
    self.setDescription( 'Assign structure-specific atlases to each anatomical structure listed in the tree.' )

    self.__layout = None
    self.__anatomicalTree = None

  def createUserInterface( self ):
    '''
    '''
    self.__layout = super( EMSegmentDefineAtlasStep, self ).createUserInterface()


    infoLabel = qt.QLabel( 'It is possible to assign an individual atlas to each structure in the tree below.' )
    infoLabel2 = qt.QLabel( 'For more specific segmentation, it is also possible to assign an additional \nparcellation map to each structure.' )
    self.__layout.addWidget( infoLabel )
    self.__layout.addWidget( infoLabel2 )

    # the anatomical tree
    anatomicalTreeGroupBox = qt.QGroupBox()
    anatomicalTreeGroupBox.setTitle( 'Atlas Map' )
    self.__layout.addWidget( anatomicalTreeGroupBox )

    anatomicalTreeGroupBoxLayout = qt.QFormLayout( anatomicalTreeGroupBox )

    self.__anatomicalTree = slicer.modulewidget.qSlicerEMSegmentAnatomicalTreeWidget()
    self.__anatomicalTree.structureNameEditable = False
    self.__anatomicalTree.labelColumnVisible = False
    self.__anatomicalTree.probabilityMapColumnVisible = True
    self.__anatomicalTree.parcellationMapColumnVisible = True
    self.__anatomicalTree.toolTip = 'If applicable, please assign structure-specific atlases to each anatomical structure.'
    self.__anatomicalTree.setSizePolicy( qt.QSizePolicy.MinimumExpanding, qt.QSizePolicy.MinimumExpanding )
    anatomicalTreeGroupBoxLayout.addWidget( self.__anatomicalTree )


  def onEntry( self, comingFrom, transitionType ):
    '''
    '''
    super( EMSegmentDefineAtlasStep, self ).onEntry( comingFrom, transitionType )

    if self.__anatomicalTree:
      self.__anatomicalTree.setMRMLManager( self.mrmlManager() )
      self.__anatomicalTree.updateWidgetFromMRML()


  def validate( self, desiredBranchId ):
    '''
    '''
    super( EMSegmentDefineAtlasStep, self ).validate( desiredBranchId )
    self.validationSucceeded( desiredBranchId )
