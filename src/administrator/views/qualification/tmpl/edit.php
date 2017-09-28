<?php

defined( '_JEXEC' ) or die;

JHtml::addIncludePath( JPATH_COMPONENT . '/helpers/html' );
JHtml::_( 'behavior.tooltip' );
JHtml::_( 'behavior.formvalidation' );
JHtml::_( 'formbehavior.chosen', 'select' );
JHtml::_( 'behavior.keepalive' );

// Import CSS
$document = JFactory::getDocument();
$document->addStyleSheet( 'components/com_swa/assets/css/swa.css' );
?>
<script type="text/javascript">
	js = jQuery.noConflict();
	js( document ).ready( function () {

	} );

	Joomla.submitbutton = function ( task ) {
		if ( task == 'qualification.cancel' ) {
			Joomla.submitform( task, document.getElementById( 'qualification-form' ) );
		}
		else {

			if ( task != 'qualification.cancel' && document.formvalidator.isValid( document.id( 'qualification-form' ) ) ) {

				Joomla.submitform( task, document.getElementById( 'qualification-form' ) );
			}
			else {
				alert( '<?php echo $this->escape(JText::_('JGLOBAL_VALIDATION_FORM_FAILED')); ?>' );
			}
		}
	}
</script>

<form action="<?php echo JRoute::_('index.php?option=com_swa&layout=edit&id=' . (int)$this->item->id); ?>"
	  method="post" enctype="multipart/form-data" name="adminForm" id="qualification-form" class="form-validate">

	<div class="form-horizontal">
		<?php echo JHtml::_( 'bootstrap.startTabSet', 'myTab', array( 'active' => 'general' ) ); ?>

		<?php echo JHtml::_('bootstrap.addTab', 'myTab', 'general', JText::_( 'Qualification', true )); ?>
		<div class="row-fluid">
			<div class="span10 form-horizontal">
				<fieldset class="adminform">

					<div class="control-group">
						<div class="control-label"><?php echo $this->form->getLabel('id'); ?></div>
						<div class="controls"><?php echo $this->form->getInput('id'); ?></div>
					</div>
					<div class="control-group">
						<div class="control-label"><?php echo $this->form->getLabel('member_id'); ?></div>
						<div class="controls"><?php echo $this->form->getInput('member_id'); ?></div>
					</div>
					<div class="control-group">
						<div class="control-label"><?php echo $this->form->getLabel('type_id'); ?></div>
						<div class="controls"><?php echo $this->form->getInput('type_id'); ?></div>
					</div>
					<div class="control-group">
						<div class="control-label"><?php echo $this->form->getLabel('expiry_date'); ?></div>
						<div class="controls"><?php echo $this->form->getInput('expiry_date'); ?></div>
					</div>
					<div class="control-group">
						<div class="control-label"><?php echo $this->form->getLabel('approved'); ?></div>
						<div class="controls"><?php echo $this->form->getInput('approved'); ?></div>
					</div>

					<p>Note: there is currently no way to change an uploaded image file.</p>
					<p>Note: there is also no way to add a qualification with a file in the backend.</p>

					<?php
					$input = JFactory::getApplication()->input;
					$data = $input->getArray();
					$qualificationId = $data['id'];
					$imgSrc = JRoute::_("index.php?option=com_swa&task=qualifications.viewimage&id=" . $qualificationId);
					?>
					<a href="<?php echo $imgSrc ?>">
						<img src="<?php echo $imgSrc ?>" width="500" height="500"/>
					</a>;

				</fieldset>
			</div>
		</div>
		<?php echo JHtml::_( 'bootstrap.endTab' ); ?>
		<?php echo JHtml::_( 'bootstrap.endTabSet' ); ?>

		<input type="hidden" name="task" value=""/>
		<?php echo JHtml::_( 'form.token' ); ?>

	</div>
</form>