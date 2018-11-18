<?php

defined('_JEXEC') or die;

jimport('joomla.application.component.view');

/**
 * View class for a list of Swa.
 */
class SwaViewMembers extends JViewLegacy
{

	protected $items;

	protected $pagination;

	protected $state;

	/**
	 * Display the view
	 */
	public function display($tpl = null)
	{
		$this->state      = $this->get('State');
		$this->items      = $this->get('Items');
		$this->pagination = $this->get('Pagination');

		// Check for errors.
		if (count($errors = $this->get('Errors')))
		{
			throw new Exception(implode("\n", $errors));
		}

		require_once JPATH_COMPONENT . '/helpers/swa.php';
		SwaHelper::addSubmenu('members');

		$this->addToolbar();

		$this->sidebar = JHtmlSidebar::render();
		parent::display($tpl);
	}

	/**
	 * Add the page title and toolbar.
	 *
	 */
	protected function addToolbar()
	{
		$actions = SwaHelper::getActions();

		JToolBarHelper::title(JText::_('Members'), 'members.png');

		// Check if the form exists before showing the add/edit buttons
		$formPath = JPATH_COMPONENT_ADMINISTRATOR . '/views/member';
		if (file_exists($formPath))
		{
			if ($actions->get('core.create'))
			{
				JToolBarHelper::addNew('member.add', 'JTOOLBAR_NEW');
			}

			if ($actions->get('core.edit') && isset($this->items[0]))
			{
				JToolBarHelper::editList('member.edit', 'JTOOLBAR_EDIT');
			}
		}

		if ($actions->get('core.delete'))
		{
			JToolBarHelper::deleteList('', 'members.delete', 'JTOOLBAR_DELETE');
		}

		if ($actions->get('core.admin'))
		{
			JToolBarHelper::preferences('com_swa');
		}

		// Set sidebar action - New in 3.0
		JHtmlSidebar::setAction('index.php?option=com_swa&view=members');

		$this->extra_sidebar = '';

	}

	protected function getSortFields()
	{
		return array(
			'id'              => JText::_('JGRID_HEADING_ID'),
			'user'            => JText::_('User'),
			'university'      => JText::_('University'),
			'lifetime_member' => JText::_('Lifetime Member'),
		);
	}

}
