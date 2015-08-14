#= require cropper/cropper
#= require shared/files

handleUploadedImage = (fileInput) ->
  file = fileInput.files[0]
  
  imageType = /image.*/

  if !file || !file.type.match(imageType)
  	return

  # Create the image element
  crop_img = document.createElement('img')
  crop_img.classList.add 'obj'
  crop_img.file = file

  # Add the image to the crop popup
  $('#crop_image_container').html crop_img
  reader = new FileReader
  reader.onload = ((aImg) ->
    (e) ->
      aImg.src = e.target.result
      return
  )(crop_img)
  reader.readAsDataURL file
  
  # Add the image to the placeholder
  placeholder_img = document.createElement('img')
  placeholder_img.classList.add 'obj'
  placeholder_img.file = file
  $('.imgPlaceHolder').html placeholder_img
  reader2 = new FileReader
  reader2.onload = ((aImg) ->
    (e) ->
      $('.theImage').attr 'value', e.target.result
      aImg.src = e.target.result
      return
  )(placeholder_img)
  reader2.readAsDataURL file


(($) ->

	$('.file_field').change ->
		handleUploadedImage this
		return


  # Load the cropper when the modal shows
  $('#cropImageModal').on 'show.bs.modal', (e) ->
  	alert 'hey'
  	$('#crop_image_container img').cropper
      aspectRatio: 1 / 1
      checkImageOrigin: true
      responsive: true
      modal: true
      crop: (data) ->
        #console.log(data);
        # Output the result data for cropping image.
        return

  # Close the modal and set the IMG when crop is saved
  $('#crop_btn').click (e) ->
		$('.imgPlaceHolder img').attr 'src', $('#crop_image_container img').cropper('getCroppedCanvas').toDataURL('image/jpeg', 1.0)
		$('#cropImageModal').modal 'hide'


  ###SHOW CUSTOM DAYS SELECTOR ###
  $('.daysOfTheMonth .radio').click (e) ->
    if $('.customDays').find('input').is(':checked')
      $('.customDaySelector').addClass 'active'
    else
      $('.customDaySelector').removeClass 'active'
    return


  # DATE PICKER!
  if $('.input-group.date').length
    $('.input-group.date').datepicker
      autoclose: 			true
      orientation: 		'top'
      todayHighlight: true


  # DAYs PICKER
  if $('.customDaySelector').length
    $('.customDaySelector').datepicker
      startDate: 					'05/01/2016'
      endDate: 						'05/31/2016'
      multidate: 					true
      multidateSeparator: ','
      calendarWeeks: 			true
      todayHighlight: 		true

    $('.customDaySelector').on 'changeDate', (event) ->
      dates = new Array
      day = new Array
      aux = ''
      dates = $('.customDaySelector').datepicker('getFormattedDate').split(',')
      i = dates.length - 1
      while i >= 0
        day = dates[i].split('/')
        aux = aux + day[1] + ','
        i--
      $('#customDaySelector_input').val aux
      return
) jQuery