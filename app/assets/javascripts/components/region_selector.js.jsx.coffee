@RegionSelector = React.createClass

  componentWillMount: ->
    RegionStore.listen(@onChange)
    RegionActions.fetch()

  componentWillUnmount: ->
    RegionStore.unlisten(@onChange)

  renderOptions: ->
    getFacetCount = @getFacetCount
    _.map @state.regions, (region) =>
      `<option key={region.name} value={region.id}>{region.name} ({getFacetCount(region.name)})</option>`

  onChange: (state) ->
    @setState(state)

  getFacetCount: (regionName) ->
    return 0 unless @props.facets
    facet = @props.facets.region_name
    pair = _.find(facet, (pair) -> pair[0] == regionName)
    return 0 unless pair
    pair[1]

  renderSuburbSelectors: ->
    return unless @getSelectedRegion()

    handler          = @handleChangeSuburb
    hasInitialSuburb = @hasInitialSuburb
    getSuburbFacetCount = @getSuburbFacetCount

    _.map @getSelectedRegion().suburbs, (suburb) ->
      `<CheckboxField 
        id={'suburb'+suburb.id} 
        checked={hasInitialSuburb(suburb.id)}
        key={suburb.id} 
        value={suburb.id} 
        facetCount={getSuburbFacetCount(suburb)}
        label={suburb.name} 
        onClick={handler} 
        name="suburb" />`

  getSuburbFacetCount: (suburb) ->
    facet = @props.facets.suburb_name
    reutrn 0 unless facet
    pair = _.find(facet, (pair) -> pair[0] == suburb.name)
    return 0 unless pair
    pair[1]

  renderSuburbTitle: ->
    return unless @getSelectedRegion()
    `<SidebarTitle value='Suburb' />`

  initialValue: ->
    @props.filters?.region

  hasInitialSuburb: (id) ->
    _.includes @props.filters?.suburb, id.toString()

  render: ->
    `<div className='form__group'>
      <select value={this.initialValue()} id='region_selector' className='select' onChange={this.handleChangeRegion}>
        <option key='any' value=''>{'All Regions (' + this.state.regions.length + ')'}</option>
        {this.renderOptions()}
      </select>

      {this.renderSuburbTitle()}
      {this.renderSuburbSelectors()}
    </div>`

  regionVal: ->
    $('select#region_selector').val()

  suburbVal: ->
    _.map $("input[name='suburb']:checked"), (el) -> el.value

  getSelectedRegion: ->
    _.find @state.regions, (r) => r.id == parseInt(@props.filters?.region)

  handleChangeRegion: ->
    @props.actions.filterData(region: @regionVal(), suburb: [])

  handleChangeSuburb: ->
    @props.actions.filterData(suburb: @suburbVal())
