import os
import unittest
import math
from __main__ import vtk, qt, ctk, slicer

#
# Charting
#

class Charting:
  def __init__(self, parent):
    parent.title = "Charting" # TODO make this more human readable by adding spaces
    parent.categories = ["Testing.TestCases"]
    parent.dependencies = []
    parent.contributors = ["Jim Miller (GE)"] # replace with "Firstname Lastname (Org)"
    parent.helpText = """
    Module to test charting.
    """
    parent.acknowledgementText = """
    This file was originally developed by Jim Miller, GE and was partially funded by NIH grant U54EB005149.
""" # replace with organization, grant and thanks.
    self.parent = parent

    # Add this test to the SelfTest module's list for discovery when the module
    # is created.  Since this module may be discovered before SelfTests itself,
    # create the list if it doesn't already exist.
    try:
      slicer.selfTests
    except AttributeError:
      slicer.selfTests = {}
    slicer.selfTests['Charting'] = self.runTest

  def runTest(self):
    tester = ChartingTest()
    tester.runTest()

#
# qChartingWidget
#

class ChartingWidget:
  def __init__(self, parent = None):
    if not parent:
      self.parent = slicer.qMRMLWidget()
      self.parent.setLayout(qt.QVBoxLayout())
      self.parent.setMRMLScene(slicer.mrmlScene)
    else:
      self.parent = parent
    self.layout = self.parent.layout()
    if not parent:
      self.setup()
      self.parent.show()

  def setup(self):
    # Instantiate and connect widgets ...

    # reload button
    # (use this during development, but remove it when delivering
    #  your module to users)
    self.reloadButton = qt.QPushButton("Reload")
    self.reloadButton.toolTip = "Reload this module."
    self.reloadButton.name = "Charting Reload"
    self.layout.addWidget(self.reloadButton)
    self.reloadButton.connect('clicked()', self.onReload)

    # reload and test button
    # (use this during development, but remove it when delivering
    #  your module to users)
    self.reloadAndTestButton = qt.QPushButton("Reload and Test")
    self.reloadAndTestButton.toolTip = "Reload this module and then run the self tests."
    self.layout.addWidget(self.reloadAndTestButton)
    self.reloadAndTestButton.connect('clicked()', self.onReloadAndTest)

    # Collapsible button
    dummyCollapsibleButton = ctk.ctkCollapsibleButton()
    dummyCollapsibleButton.text = "A collapsible button"
    self.layout.addWidget(dummyCollapsibleButton)

    # Layout within the dummy collapsible button
    dummyFormLayout = qt.QFormLayout(dummyCollapsibleButton)

    # HelloWorld button
    helloWorldButton = qt.QPushButton("Hello world")
    helloWorldButton.toolTip = "Print 'Hello world' in standard ouput."
    dummyFormLayout.addWidget(helloWorldButton)
    helloWorldButton.connect('clicked(bool)', self.onHelloWorldButtonClicked)

    # Add vertical spacer
    self.layout.addStretch(1)

    # Set local var as instance attribute
    self.helloWorldButton = helloWorldButton

  def onHelloWorldButtonClicked(self):
    print "Hello World !"

  def onReload(self,moduleName="Charting"):
    """Generic reload method for any scripted module.
    ModuleWizard will subsitute correct default moduleName.
    """
    import imp, sys, os, slicer

    widgetName = moduleName + "Widget"

    # reload the source code
    # - set source file path
    # - load the module to the global space
    filePath = eval('slicer.modules.%s.path' % moduleName.lower())
    p = os.path.dirname(filePath)
    if not sys.path.__contains__(p):
      sys.path.insert(0,p)
    fp = open(filePath, "r")
    globals()[moduleName] = imp.load_module(
        moduleName, fp, filePath, ('.py', 'r', imp.PY_SOURCE))
    fp.close()

    # rebuild the widget
    # - find and hide the existing widget
    # - create a new widget in the existing parent
    parent = slicer.util.findChildren(name='%s Reload' % moduleName)[0].parent()
    for child in parent.children():
      try:
        child.hide()
      except AttributeError:
        pass
    # Remove spacer items
    item = parent.layout().itemAt(0)
    while item:
      parent.layout().removeItem(item)
      item = parent.layout().itemAt(0)
    # create new widget inside existing parent
    globals()[widgetName.lower()] = eval(
        'globals()["%s"].%s(parent)' % (moduleName, widgetName))
    globals()[widgetName.lower()].setup()

  def onReloadAndTest(self,moduleName="Charting"):
    self.onReload()
    evalString = 'globals()["%s"].%sTest()' % (moduleName, moduleName)
    tester = eval(evalString)
    tester.runTest()

#
# ChartingLogic
#

class ChartingLogic:
  """This class should implement all the actual 
  computation done by your module.  The interface 
  should be such that other python code can import
  this class and make use of the functionality without
  requiring an instance of the Widget
  """
  def __init__(self):
    pass

  def hasImageData(self,volumeNode):
    """This is a dummy logic method that 
    returns true if the passed in volume
    node has valid image data
    """
    if not volumeNode:
      print('no volume node')
      return False
    if volumeNode.GetImageData() == None:
      print('no image data')
      return False
    return True


class ChartingTest(unittest.TestCase):
  """
  This is the test case for your scripted module.
  """

  def delayDisplay(self,message,msec=1000):
    """This utility method displays a small dialog and waits.
    This does two things: 1) it lets the event loop catch up
    to the state of the test so that rendering and widget updates
    have all taken place before the test continues and 2) it
    shows the user/developer/tester the state of the test
    so that we'll know when it breaks.
    """
    print(message)
    self.info = qt.QDialog()
    self.infoLayout = qt.QVBoxLayout()
    self.info.setLayout(self.infoLayout)
    self.label = qt.QLabel(message,self.info)
    self.infoLayout.addWidget(self.label)
    qt.QTimer.singleShot(msec, self.info.close)
    self.info.exec_()

  def setUp(self):
    """ Do whatever is needed to reset the state - typically a scene clear will be enough.
    """
    slicer.mrmlScene.Clear(0)

  def runTest(self):
    """Run as few or as many tests as needed here.
    """
    self.setUp()
    self.test_Charting1()

  def test_Charting1(self):
    """ Testing charting
    """

    self.delayDisplay("Starting the test")
    #
    # first, get some data
    #
    #import urllib
    #downloads = (
    #    ('http://slicer.kitware.com/midas3/download?items=5767', 'FA.nrrd', slicer.util.loadVolume),
    #    )
    #
    #for url,name,loader in downloads:
    #  filePath = slicer.app.temporaryPath + '/' + name
    #  if not os.path.exists(filePath) or os.stat(filePath).st_size == 0:
    #    print('Requesting download %s from %s...\n' % (name, url))
    #    urllib.urlretrieve(url, filePath)
    #  if loader:
    #    print('Loading %s...\n' % (name,))
    #    loader(filePath)
    #self.delayDisplay('Finished with download and loading\n')

    #volumeNode = slicer.util.getNode(pattern="FA")
    #logic = ChartingLogic()
    #self.assertTrue( logic.hasImageData(volumeNode) )

    # Change the layout to one that has a chart.  This created the ChartView
    ln = slicer.util.getNode(pattern='vtkMRMLLayoutNode*')
    ln.SetViewArrangement(24)

    # Get the first ChartView node
    cvn = slicer.util.getNode(pattern='vtkMRMLChartViewNode*')
    
    # Create arrays of data
    dn = slicer.mrmlScene.AddNode(slicer.vtkMRMLDoubleArrayNode())
    a = dn.GetArray()
    a.SetNumberOfTuples(600)
    x = range(0, 600)
    for i in range(len(x)):
      a.SetComponent(i, 0, x[i]/50.0)
      a.SetComponent(i, 1, math.sin(x[i]/50.0))
      a.SetComponent(i, 2, 0)

    dn2 = slicer.mrmlScene.AddNode(slicer.vtkMRMLDoubleArrayNode())
    a = dn2.GetArray()
    a.SetNumberOfTuples(600)
    x = range(0, 600)
    for i in range(len(x)):
      a.SetComponent(i, 0, x[i]/50.0)
      a.SetComponent(i, 1, math.cos(x[i]/50.0))
      a.SetComponent(i, 2, 0)

    # Create the ChartNode, 
    cn = slicer.mrmlScene.AddNode(slicer.vtkMRMLChartNode())

    # Add data to the Chart
    cn.AddArray('A double array', dn.GetID())
    cn.AddArray('Another double array', dn2.GetID())

    # Configure properties of the Chart
    cn.SetProperty('default', 'title', 'A simple chart with 2 curves')
    cn.SetProperty('default', 'xAxisLabel', 'Something in x')
    cn.SetProperty('default', 'yAxisLabel', 'Something in y')

    # Set the chart to display
    cvn.SetChartNodeID(cn.GetID())
    self.delayDisplay('A simple chart with 2 curves')

    # Create another ChartNode
    cn = slicer.mrmlScene.AddNode(slicer.vtkMRMLChartNode())

    # Add data to the Chart
    cn.AddArray('Just one array', dn.GetID())

    # Configure properties of the chart
    cn.SetProperty('default', 'title', 'A simple chart with 1 curve')
    cn.SetProperty('default', 'xAxisLabel', 'Just x')
    cn.SetProperty('default', 'yAxisLabel', 'Just y')

    # Set the chart to display
    cvn.SetChartNodeID(cn.GetID())
    self.delayDisplay('A simple chart with 1 curve')

    # Create another ChartNode
    cn = slicer.mrmlScene.AddNode(slicer.vtkMRMLChartNode())

    # Add data to the Chart
    cn.AddArray('The other array', dn2.GetID())

    # Set properties on the chart
    cn.SetProperty('default', 'title', 'A simple chart with another curve')
    cn.SetProperty('default', 'xAxisLabel', 'time')
    cn.SetProperty('default', 'yAxisLabel', 'velocity')
    cn.SetProperty('The other array', 'showLines', 'on')
    cn.SetProperty('The other array', 'showMarkers', 'off')
    cn.SetProperty('The other array', 'color', '#fe7d20')

    # Set the chart to display
    cvn.SetChartNodeID(cn.GetID())
    self.delayDisplay('A simple chart with another curve')

    # Create another data array
    dn3 = slicer.mrmlScene.AddNode(slicer.vtkMRMLDoubleArrayNode())
    a = dn3.GetArray()
    a.SetNumberOfTuples(12)
    x = range(0, 12)
    for i in range(len(x)):
      a.SetComponent(i, 0, x[i]/4.0)
      a.SetComponent(i, 1, math.sin(x[i]/4.0))
      a.SetComponent(i, 2, 0)

    # Create another ChartNode
    cn = slicer.mrmlScene.AddNode(slicer.vtkMRMLChartNode())

    # Add data to the chart
    cn.AddArray('Periodic', dn3.GetID())

    # Configure properties of the Chart
    cn.SetProperty('default', 'title', 'A bar chart')
    cn.SetProperty('default', 'xAxisLabel', 'time')
    cn.SetProperty('default', 'yAxisLabel', 'velocity')
    cn.SetProperty('default', 'type', 'Bar');

    # Set the chart to display
    cvn.SetChartNodeID(cn.GetID())
    self.delayDisplay('A bar chart')

    #
    self.delayDisplay('Test passed!')
