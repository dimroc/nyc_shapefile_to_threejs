describe "graphics.WorldRenderer", ->
  describe "#constructor", ->
    it "should create the camera, scene, and renderer", ->
      worldRenderer = new App.WorldRenderer()
      expect(worldRenderer.renderer).toBeDefined()
      expect(worldRenderer.camera).toBeDefined()
      worldRenderer.destroy()

  describe "when constructed", ->
    worldRenderer = null
    beforeEach ->
      worldRenderer = new App.WorldRenderer()

    afterEach ->
      worldRenderer.destroy()

    describe "#addRegionMeshes", ->
      it "should add to its children", ->
        mesh = new THREE.Mesh()
        worldRenderer.addRegionMeshes(mesh)
        expect(worldRenderer.meshes()).toInclude(mesh)
