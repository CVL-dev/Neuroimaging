from __main__ import qt, ctk

from EMSegmentStep import *

class EMSegmentDummyStep( EMSegmentStep ) :

  def __init__( self, stepid ):
    self.initialize( stepid )
    self.setName( self.id() )
    self.setDescription( 'YYY' )

  def createUserInterface( self ):
    '''
    '''
    self.__layout = super( EMSegmentDummyStep, self ).createUserInterface()


    label = qt.QLabel( "PLACEHOLDER: " + self.id() )
    self.__layout.addWidget( label )


  def validate( self, desiredBranchId ):
    '''
    '''
    super( EMSegmentDummyStep, self ).validate( desiredBranchId )

    self.validationSucceeded( desiredBranchId )
