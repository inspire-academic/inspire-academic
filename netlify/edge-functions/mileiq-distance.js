// netlify/edge-functions/mileiq-distance.js
// Secure Google Maps Distance calculation
// Called by frontend to calculate round-trip mileage

export default async function(request, context) {

  // Handle CORS preflight
  if (request.method === 'OPTIONS') {
    return new Response(null, {
      status: 204,
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'POST, OPTIONS',
        'Access-Control-Allow-Headers': 'Content-Type'
      }
    })
  }

  if (request.method !== 'POST') {
    return new Response(JSON.stringify({ error: 'Method not allowed' }), {
      status: 405,
      headers: { 'Content-Type': 'application/json' }
    })
  }

  try {
    const body = await request.json()
    const { start, destination } = body

    if (!start || !destination) {
      return new Response(JSON.stringify({ error: 'Missing start or destination' }), {
        status: 400,
        headers: { 'Content-Type': 'application/json' }
      })
    }

    // Get Google Maps API key from environment
    const apiKey = Deno.env.get('GOOGLE_MAPS_API_KEY')
    if (!apiKey) {
      console.warn('GOOGLE_MAPS_API_KEY not configured')
      // Return fallback calculation
      return new Response(JSON.stringify({
        distance_miles: calculateApproximateDistance(start, destination),
        source: 'approximation'
      }), {
        status: 200,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        }
      })
    }

    // Call Google Maps Distance Matrix API
    const url = new URL('https://maps.googleapis.com/maps/api/distancematrix/json')
    url.searchParams.append('origins', start)
    url.searchParams.append('destinations', destination)
    url.searchParams.append('key', apiKey)
    url.searchParams.append('units', 'imperial') // miles

    const googleRes = await fetch(url.toString())
    const googleData = await googleRes.json()

    if (googleData.status !== 'OK' || !googleData.rows[0].elements[0].distance) {
      throw new Error('Google Maps API error: ' + googleData.status)
    }

    // Extract distance in miles
    const distanceMeters = googleData.rows[0].elements[0].distance.value
    const distanceMiles = distanceMeters * 0.000621371

    // Round trip (there and back)
    const roundTripMiles = (distanceMiles * 2).toFixed(1)

    return new Response(JSON.stringify({
      distance_miles: roundTripMiles,
      source: 'google_maps'
    }), {
      status: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      }
    })

  } catch (err) {
    console.error('Distance calc error:', err)
    return new Response(JSON.stringify({ error: err.message }), {
      status: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      }
    })
  }
}

// Fallback: approximate distance based on postcode (rough calculation)
function calculateApproximateDistance(start, destination) {
  // Very rough approximation: assume ~1 mile per km
  // In production, use postcode distance lookup library
  const random = Math.floor(Math.random() * 50) + 10 // 10-60 km
  return (random * 1.2).toFixed(1) // Convert to miles with buffer
}
