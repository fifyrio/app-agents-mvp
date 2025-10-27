/**
 * Wardrobe Handler Module
 *
 * Handles HTTP requests for the wardrobe endpoint, providing outfit recommendations
 * and filters based on user preferences and category selections.
 *
 * @module handlers/wardrobe
 */

import { WARDROBE_FILTERS, WARDROBE_SCENES, getValidCategories } from '../data/wardrobe.js';

/**
 * Filters wardrobe scenes by category
 *
 * @param {string} category - The category to filter by (e.g., "work", "date", "all")
 * @returns {Object[]} Filtered array of wardrobe scenes
 */
function filterScenesByCategory(category) {
  // If category is "all" or not provided, return all scenes
  if (!category || category === 'all') {
    return WARDROBE_SCENES;
  }

  // Filter scenes by the specified category
  return WARDROBE_SCENES.filter(scene => scene.category === category);
}

/**
 * Updates filter selection state based on the active category
 *
 * @param {string} activeCategory - The currently selected category
 * @returns {Object[]} Array of filters with updated selection state
 */
function updateFilterSelection(activeCategory) {
  return WARDROBE_FILTERS.map(filter => ({
    ...filter,
    selected: filter.id === activeCategory
  }));
}

/**
 * Validates if a category is valid
 *
 * @param {string} category - The category to validate
 * @returns {boolean} True if the category is valid, false otherwise
 */
function isValidCategory(category) {
  const validCategories = getValidCategories();
  return validCategories.includes(category);
}

/**
 * Handles GET requests to the /wardrobe endpoint
 *
 * Returns outfit recommendations and filter options. Supports optional category
 * filtering via query parameter.
 *
 * Query Parameters:
 *   - category (optional): Filter scenes by category (work, date, travel, party, interview, all)
 *
 * Response Format:
 * {
 *   "filters": [
 *     { "id": "all", "title": "All", "selected": true },
 *     ...
 *   ],
 *   "scenes": [
 *     {
 *       "id": "scene_id",
 *       "title": "Scene Title",
 *       "subtitle": "Description",
 *       "palette": ["#HEX1", "#HEX2"],
 *       "image_url": "https://...",
 *       "tags": ["tag1"],
 *       "category": "work",
 *       "is_premium": false
 *     },
 *     ...
 *   ]
 * }
 *
 * @param {Object} c - Hono context object
 * @returns {Response} JSON response with filters and scenes
 *
 * @example
 * // Get all wardrobe scenes
 * GET /wardrobe
 *
 * @example
 * // Get only work-related scenes
 * GET /wardrobe?category=work
 */
export function handleWardrobeRequest(c) {
  try {
    // Extract category from query parameters
    const category = c.req.query('category') || 'all';

    // Validate category if provided and not "all"
    if (category !== 'all' && !isValidCategory(category)) {
      return c.json(
        {
          error: `Invalid category. Valid categories are: ${getValidCategories().join(', ')}`
        },
        400
      );
    }

    // Filter scenes based on category
    const filteredScenes = filterScenesByCategory(category);

    // Update filter selection state
    const filters = updateFilterSelection(category);

    // Return response with filtered data
    return c.json({
      filters,
      scenes: filteredScenes
    });
  } catch (error) {
    // Log error for debugging (visible in Cloudflare Workers logs)
    console.error('Error in wardrobe handler:', error);

    // Return generic error message to client
    return c.json(
      {
        error: 'An error occurred while fetching wardrobe data'
      },
      500
    );
  }
}
